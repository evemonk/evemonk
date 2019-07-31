# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationAllianceHistoryImporter do
  describe "#import" do
    context "when fresh data available" do
      context "when character found" do
        let(:corporation_id) { double }

        subject { described_class.new(corporation_id) }

        let(:eve_corporation) { instance_double(Eve::Corporation) }

        before { expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: corporation_id).and_return(eve_corporation) }

        let(:record_id) { double }

        let(:json) { double }

        let(:url) { double }

        let(:new_etag) { double }

        let(:entry) { instance_double(EveOnline::ESI::Models::CorporationAllianceHistory, record_id: record_id, as_json: json) }

        let(:entries) { [entry] }

        let(:esi) do
          instance_double(EveOnline::ESI::CorporationAllianceHistory,
                          url: url,
                          not_modified?: false,
                          etag: new_etag,
                          entries: entries)
        end

        before { expect(EveOnline::ESI::CorporationAllianceHistory).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

        let(:etag) { instance_double(Eve::Etag, etag: "22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

        before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

        before { expect(esi).to receive(:etag=).with("22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

        let(:corporation_alliance_history) { instance_double(Eve::CorporationAllianceHistory) }

        before do
          #
          # eve_corporation.corporation_alliance_histories
          #                .find_or_initialize_by(record_id: entry.record_id) # => corporation_alliance_history
          #
          expect(eve_corporation).to receive(:corporation_alliance_histories) do
            double.tap do |a|
              expect(a).to receive(:find_or_initialize_by).with(record_id: record_id)
                .and_return(corporation_alliance_history)
            end
          end
        end

        before { expect(corporation_alliance_history).to receive(:update!).with(json) }

        before { expect(etag).to receive(:update!).with(etag: new_etag) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when corporation not found (404)" do
        let(:corporation_id) { double }

        subject { described_class.new(corporation_id) }

        let(:eve_corporation) { instance_double(Eve::Corporation) }

        before { expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: corporation_id).and_return(eve_corporation) }

        before { expect(EveOnline::ESI::CorporationAllianceHistory).to receive(:new).with(corporation_id: corporation_id).and_raise(EveOnline::Exceptions::ResourceNotFound) }

        before { expect(eve_corporation).to receive(:destroy!) }

        specify { expect { subject.import }.not_to raise_error }
      end

      context "when corporation not found (ActiveRecord::RecordNotFound)" do
        let(:corporation_id) { double }

        subject { described_class.new(corporation_id) }

        before { expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: corporation_id).and_raise(ActiveRecord::RecordNotFound) }

        before do
          #
          # Rails.logger.info("Corporation with ID #{ corporation_id } not found")
          #
          expect(Rails).to receive(:logger) do
            double.tap do |a|
              expect(a).to receive(:info).with("Corporation with ID #{corporation_id} not found")
            end
          end
        end

        specify { expect { subject.import }.not_to raise_error }
      end
    end

    context "when no fresh data available" do
      let(:corporation_id) { double }

      subject { described_class.new(corporation_id) }

      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before { expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: corporation_id).and_return(eve_corporation) }

      let(:url) { double }

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationAllianceHistory,
                        url: url,
                        not_modified?: true)
      end

      before { expect(EveOnline::ESI::CorporationAllianceHistory).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      let(:etag) { instance_double(Eve::Etag, etag: "22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

      before { expect(Eve::Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      before { expect(esi).to receive(:etag=).with("22c39689783a86032b8d43fa0b2e8f4809c4f38a585e39471035aa8b") }

      before { expect(etag).not_to receive(:update!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end
end
