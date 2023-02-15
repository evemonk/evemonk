# frozen_string_literal: true

require "rails_helper"

describe Eve::CorporationAllianceHistoryImporter do
  let(:corporation_id) { double }

  subject { described_class.new(corporation_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    context "when eve corporation found" do
      let(:record_id) { double }

      let(:json) { double }

      let(:entry) { instance_double(EveOnline::ESI::Models::CorporationAllianceHistory, record_id: record_id, as_json: json) }

      let(:entries) { [entry] }

      let(:esi) do
        instance_double(EveOnline::ESI::CorporationAllianceHistory,
          entries: entries)
      end

      before { expect(subject).to receive(:esi).and_return(esi) }

      let(:eve_corporation) { instance_double(Eve::Corporation) }

      before { expect(Eve::Corporation).to receive(:find).with(corporation_id).and_return(eve_corporation) }

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

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve corporation not found (ActiveRecord::RecordNotFound)" do
      before { expect(Eve::Corporation).to receive(:find_by!).with(corporation_id: corporation_id).and_raise(ActiveRecord::RecordNotFound) }

      before do
        #
        # Rails.logger.info("Corporation with ID #{corporation_id} not found")
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

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationAllianceHistory) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CorporationAllianceHistory) }

      before { expect(EveOnline::ESI::CorporationAllianceHistory).to receive(:new).with(corporation_id: corporation_id).and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
