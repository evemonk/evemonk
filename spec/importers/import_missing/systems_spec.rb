# frozen_string_literal: true

require "rails_helper"

describe ImportMissing::Systems do
  describe "#import" do
    let(:system_id) { double }

    before { expect(subject).to receive(:system_ids).and_return([system_id]) }

    before { expect(Eve::UpdateSystemJob).to receive(:perform_later).with(system_id) }

    specify { expect { subject.import }.not_to raise_error }
  end

  # private methods

  describe "#system_ids" do
    let!(:eve_system) { create(:eve_system, id: 30_003_498) }

    let!(:character_1) { create(:character, current_solar_system_id: nil) }

    let!(:character_2) { create(:character, current_solar_system_id: 30_003_498) }

    let!(:character_3) { create(:character, current_solar_system_id: 30_003_499) }

    specify { expect(subject.send(:system_ids)).to eq([30_003_499]) }
  end
end
