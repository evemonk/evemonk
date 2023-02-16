# frozen_string_literal: true

require "rails_helper"

describe ImportMissing::Corporations do
  describe "#import" do
    let(:corporation_id) { double }

    before { expect(subject).to receive(:corporation_ids).and_return([corporation_id]) }

    before { expect(Eve::UpdateCorporationJob).to receive(:perform_later).with(corporation_id) }

    before { expect(Eve::UpdateCorporationLogoJob).to receive(:perform_later).with(corporation_id) }

    specify { expect { subject.import }.not_to raise_error }
  end

  # private methods

  describe "#corporation_ids" do
    let!(:eve_corporation) { create(:eve_corporation, id: 98_388_312) }

    let!(:character_1) { create(:character, corporation_id: nil) }

    let!(:character_2) { create(:character, corporation_id: 98_565_696) }

    let!(:character_3) { create(:character, corporation_id: 98_388_312) }

    specify { expect(subject.send(:corporation_ids)).to eq([98_565_696]) }
  end
end
