# frozen_string_literal: true

require "rails_helper"

describe ImportMissing::Alliances do
  describe "#import" do
    let(:alliance_id) { double }

    before { expect(subject).to receive(:alliance_ids).and_return([alliance_id]) }

    before { expect(Eve::UpdateAllianceJob).to receive(:perform_later).with(alliance_id) }

    before { expect(Eve::UpdateAllianceLogoJob).to receive(:perform_later).with(alliance_id) }

    specify { expect { subject.import }.not_to raise_error }
  end

  # private methods

  describe "#alliance_ids" do
    let!(:eve_alliance) { create(:eve_alliance, id: 1_354_830_081) }

    let!(:character_1) { create(:character, alliance_id: nil) }

    let!(:character_2) { create(:character, alliance_id: 99_008_595) }

    let!(:character_3) { create(:character, alliance_id: 1_354_830_081) }

    specify { expect(subject.send(:alliance_ids)).to eq([99_008_595]) }
  end
end
