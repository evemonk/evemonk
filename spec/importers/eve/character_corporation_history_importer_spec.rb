# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterCorporationHistoryImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when character found" do
        let(:character_id) { double }

        subject { described_class.new(character_id) }

        let(:eve_character) { instance_double(Eve::Character) }

        before { expect(Eve::Character).to receive(:find_by!).with(character_id: character_id).and_return(eve_character) }

        let(:record_id) { double }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:entry) { instance_double(EveOnline::ESI::Models::CharacterCorporationHistory, record_id: record_id, as_json: json) }

        let(:entries) { [entry] }

        let(:response) { double }

        let(:esi) do
          instance_double(EveOnline::ESI::CharacterCorporationHistory,
            url: url,
            not_modified?: false,
            etag: new_etag,
            entries: entries,
            response: response)
        end

        before { expect(EveOnline::ESI::CharacterCorporationHistory).to receive(:new).with(character_id: character_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

        let(:character_corporation_history) { instance_double(Eve::CharacterCorporationHistory) }

        before do
          #
          # eve_character.character_corporation_histories
          #              .find_or_initialize_by(record_id: entry.record_id) # => character_corporation_history
          #
          expect(eve_character).to receive(:character_corporation_histories) do
            double.tap do |a|
              expect(a).to receive(:find_or_initialize_by).with(record_id: record_id)
                .and_return(character_corporation_history)
            end
          end
        end

        before { expect(character_corporation_history).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag, body: response) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when character not found (ActiveRecord::RecordNotFound)" do
        let(:character_id) { double }

        subject { described_class.new(character_id) }

        before { expect(Eve::Character).to receive(:find_by!).with(character_id: character_id).and_raise(ActiveRecord::RecordNotFound) }

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

    context "when no fresh data available" do
      let(:character_id) { double }

      subject { described_class.new(character_id) }

      let(:eve_character) { instance_double(Eve::Character) }

      before { expect(Eve::Character).to receive(:find_by!).with(character_id: character_id).and_return(eve_character) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterCorporationHistory,
          url: url,
          not_modified?: true)
      end

      before { expect(EveOnline::ESI::CharacterCorporationHistory).to receive(:new).with(character_id: character_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
