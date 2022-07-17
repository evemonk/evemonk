# frozen_string_literal: true

require "rails_helper"

describe ImportMissing::Ships do
  describe "#import" do
    let(:ship_id) { double }

    before { expect(subject).to receive(:ship_ids).and_return([ship_id]) }

    before { expect(Eve::UpdateTypeJob).to receive(:perform_later).with(ship_id) }

    specify { expect { subject.import }.not_to raise_error }
  end

  # private methods

  describe "#ship_ids" do
    let!(:eve_type) { create(:eve_type, id: 638) }

    let!(:character_1) { create(:character, current_ship_type_id: nil) }

    let!(:character_2) { create(:character, current_ship_type_id: 638) }

    let!(:character_3) { create(:character, current_ship_type_id: 28_710) }

    specify { expect(subject.send(:ship_ids)).to eq([28_710]) }
  end
end
