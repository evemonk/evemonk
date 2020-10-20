# frozen_string_literal: true

require "rails_helper"

describe CharacterImplantsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character).twice }

    let(:implant_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterImplants,
        implant_ids: [implant_id])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

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

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterImplants) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterImplants) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterImplants).to receive(:new).with(character_id: character_id).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
