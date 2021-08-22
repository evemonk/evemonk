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

  # describe "#ship_ids" do
  #   let!(:eve_type) { create(:eve_type, type_id: 638) }
  #
  #   let!(:character_1) { create(:character, current_ship_type_id: nil) }
  #
  #   let!(:character_2) { create(:character, current_ship_type_id: 638) }
  #
  #   let!(:character_3) { create(:character, current_ship_type_id: 28_710) }
  #
  #   specify { expect(subject.send(:ship_ids)).to eq([28_710]) }
  # end
end
