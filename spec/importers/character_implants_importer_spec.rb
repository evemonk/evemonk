# frozen_string_literal: true

require "rails_helper"

describe CharacterImplantsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-clones.read_implants.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(5).times }

      let(:implant_id) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterImplants,
          implant_ids: [implant_id],
          scope: "esi-clones.read_implants.v1")
      end

      before { expect(EveOnline::ESI::CharacterImplants).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before do
        #
        # character.character_implants.destroy_all
        #
        expect(character).to receive(:character_implants) do
          double.tap do |a|
            expect(a).to receive(:destroy_all)
          end
        end
      end

      before do
        #
        # character.character_implants.create!(type_id: implant_id)
        #
        expect(character).to receive(:character_implants) do
          double.tap do |a|
            expect(a).to receive(:create!).with(type_id: implant_id)
          end
        end
      end

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterImplants,
          scope: "esi-clones.read_implants.v1")
      end

      before { expect(EveOnline::ESI::CharacterImplants).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

      before { expect(character).not_to receive(:character_implants) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
