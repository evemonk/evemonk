# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::LocalStarsImporter do
  describe "#import" do
    let(:star_id) { double }

    before do
      #
      # Eve::Star.pluck(:star_id) => [star_id]
      #
      expect(Eve::Star).to receive(:pluck).with(:star_id).and_return([star_id])
    end

    before { expect(Eve::UpdateStarJob).to receive(:perform_later).with(star_id) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
