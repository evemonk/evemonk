# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::AlliancesImporter do
  it { expect(subject).to be_a(Eve::BaseImporter) }

  describe "#import" do
    context "when database is empty" do
      before { VCR.insert_cassette "esi/alliances/list" }

      after { VCR.eject_cassette }

      before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).exactly(3541).times }

      specify { expect { subject.import }.not_to change(Eve::Alliance, :count) }
    end

    context "when database is not empty" do
      context "when alliance is not exists anymore" do
        let!(:alliance) { create(:eve_alliance, id: 123_456) }

        let!(:corporation_1) { create(:eve_corporation, id: 123_444, alliance_id: alliance) }

        let!(:corporation_2) { create(:eve_corporation, id: 222_444, alliance_id: alliance) }

        before { VCR.insert_cassette "esi/alliances/list" }

        after { VCR.eject_cassette }

        before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).at_least(1).time }

        before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(123_444) }

        before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(222_444) }

        specify { expect { subject.import }.to change(Eve::Alliance, :count).by(-1) }
      end
    end
  end
end
