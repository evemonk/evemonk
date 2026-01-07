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
      before { VCR.insert_cassette "esi/alliances/list" }

      after { VCR.eject_cassette }

      let!(:alliance) { create(:eve_alliance, id: 123_456) }

      let!(:corporation_1) { create(:eve_corporation, id: 123_444, alliance: alliance) }

      let!(:corporation_2) { create(:eve_corporation, id: 222_444, alliance: alliance) }

      before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).exactly(3541).times }

      before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(123_444) }

      before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(222_444) }

      specify { expect { subject.import }.to change(Eve::Alliance, :count).by(-1) }
    end
  end
end
