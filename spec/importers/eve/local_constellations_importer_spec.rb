# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalConstellationsImporter do
  describe "#import" do
    let(:constellation_id) { double }

    before do
      #
      # Eve::Constellation.pluck(:constellation_id) => [constellation_id]
      #
      expect(Eve::Constellation).to receive(:pluck).with(:constellation_id).and_return([constellation_id])
    end

    before { expect(Eve::UpdateConstellationJob).to receive(:perform_later).with(constellation_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
