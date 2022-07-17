# frozen_string_literal: true

require "rails_helper"

describe ImportMissing::Stations do
  describe "#import" do
    let(:station_id) { double }

    before { expect(subject).to receive(:station_ids).and_return([station_id]) }

    before { expect(Eve::UpdateStationJob).to receive(:perform_later).with(station_id) }

    specify { expect { subject.import }.not_to raise_error }
  end

  # private methods

  describe "#station_ids" do
    let!(:eve_station) { create(:eve_station, id: 60_008_674) }

    let!(:character_1) { create(:character, current_station_id: nil) }

    let!(:character_2) { create(:character, current_station_id: 60_008_674) }

    let!(:character_3) { create(:character, current_station_id: 60_008_677) }

    specify { expect(subject.send(:station_ids)).to eq([60_008_677]) }
  end
end
