# frozen_string_literal: true

require "rails_helper"

describe ImportMissing::ForDevelopment do
  describe "#import" do
    before { expect(Eve::UpdateRacesJob).to receive(:perform_later) }

    specify { expect { subject.import }.not_to raise_error }
  end
end
