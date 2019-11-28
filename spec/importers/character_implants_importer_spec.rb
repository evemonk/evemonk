# frozen_string_literal: true

require "rails_helper"

describe CharacterImplantsImporter do
  context "when character found" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    let(:access_token) { double }

    let(:character) { instance_double(Character, access_token: access_token) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }

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

    let(:implant_id) { double }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterImplants,
        implant_ids: [implant_id])
    end

    before { expect(EveOnline::ESI::CharacterImplants).to receive(:new).with(character_id: character_id, token: access_token).and_return(esi) }

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

    specify { expect { subject.import }.not_to raise_error }
  end

  context "when character not found (ActiveRecord::RecordNotFound)" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_raise(ActiveRecord::RecordNotFound) }

    before do
      #
      # Rails.logger.info("Character with ID #{ character_id } not found")
      #
      expect(Rails).to receive(:logger) do
        double.tap do |a|
          expect(a).to receive(:info).with("Character with ID #{character_id} not found")
        end
      end
    end

    specify { expect { subject.import }.not_to raise_error }
  end
end
