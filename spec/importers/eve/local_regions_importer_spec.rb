# frozen_string_literal: true

require "rails_helper"

describe Eve::LocalRegionsImporter do
  describe "#import" do
    let(:region_id) { double }

    before do
      #
      # Eve::Region.pluck(:id) # => [region_id]
      #
      expect(Eve::Region).to receive(:pluck).with(:id).and_return([region_id])
    end

    before { expect(Eve::UpdateRegionJob).to receive(:perform_later).with(region_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
