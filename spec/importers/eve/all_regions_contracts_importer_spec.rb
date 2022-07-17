# frozen_string_literal: true

require "rails_helper"

describe Eve::AllRegionsContractsImporter do
  describe "#import" do
    let(:id) { double }

    before { expect(subject).to receive(:region_ids).and_return([id]) }

    before { expect(Eve::RegionContractsJob).to receive(:perform_later).with(id) }

    specify { expect { subject.import }.not_to raise_error }
  end

  # private methods

  describe "#region_ids" do
    let!(:eve_region_1) { create(:eve_region, id: 1) }

    let!(:eve_region_2) { create(:eve_region, id: 2) }

    specify { expect(subject.send(:region_ids)).to eq([1, 2]) }
  end
end
