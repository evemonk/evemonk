# frozen_string_literal: true

require "rails_helper"

describe CharacterCorporationHistoryImporter do
  context "when character found" do
    let(:character_id) { double }

    subject { described_class.new(character_id) }

    let(:access_token) { double }

    let(:character) { instance_double(Character, access_token: access_token) }

    before { expect(Character).to receive(:find_by!).with(character_id: character_id).and_return(character) }

    let(:json) { double }

    let(:record_id) { double }

    let(:entry) { instance_double(EveOnline::ESI::Models::CharacterCorporationHistory, record_id: record_id, as_json: json) }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterCorporationHistory,
        entries: [entry])
    end

    before { expect(EveOnline::ESI::CharacterCorporationHistory).to receive(:new).with(character_id: character_id).and_return(esi) }

    let(:character_corporation_history) { instance_double(CharacterCorporationHistory) }

    before do
      #
      # character.character_corporation_histories.find_or_initialize_by(record_id: entry.record_id)
      #
      expect(character).to receive(:character_corporation_histories) do
        double.tap do |a|
          expect(a).to receive(:find_or_initialize_by).with(record_id: record_id)
            .and_return(character_corporation_history)
        end
      end
    end

    before { expect(character_corporation_history).to receive(:update!).with(json) }

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
