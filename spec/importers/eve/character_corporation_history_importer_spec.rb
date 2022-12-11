# frozen_string_literal: true

require "rails_helper"

describe Eve::CharacterCorporationHistoryImporter do
  let(:id) { double }

  subject { described_class.new(id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    before { expect(subject).to receive(:configure_etag) }

    context "when etag cache hit" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterCorporationHistory, not_modified?: true) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when etag cache miss" do
      context "when eve character found" do
        let(:record_id) { double }

        let(:json) { double }

        let(:entry) { instance_double(EveOnline::ESI::Models::CharacterCorporationHistory, record_id: record_id, as_json: json) }

        let(:entries) { [entry] }

        let(:esi) do
          instance_double(EveOnline::ESI::CharacterCorporationHistory,
            not_modified?: false,
            entries: entries)
        end

        before { expect(subject).to receive(:esi).and_return(esi).twice }

        let(:eve_character) { instance_double(Eve::Character) }

        before { expect(Eve::Character).to receive(:find).with(id).and_return(eve_character) }

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

        before { expect(subject).to receive(:update_etag) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when eve character not found (ActiveRecord::RecordNotFound)" do
        let(:esi) do
          instance_double(EveOnline::ESI::CharacterCorporationHistory,
            not_modified?: false)
        end

        before { expect(subject).to receive(:esi).and_return(esi) }

        before { expect(Eve::Character).to receive(:find).with(id).and_raise(ActiveRecord::RecordNotFound) }

        before do
          #
          # Rails.logger.info("Character with ID #{id} not found")
          #
          expect(Rails).to receive(:logger) do
            double.tap do |a|
              expect(a).to receive(:info).with("Character with ID #{id} not found")
            end
          end
        end

        specify { expect { subject.import }.not_to raise_error }
      end
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterCorporationHistory) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterCorporationHistory) }

      before { expect(EveOnline::ESI::CharacterCorporationHistory).to receive(:new).with(character_id: id).and_return(esi) }

      specify { expect { subject.esi }.not_to raise_error }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
