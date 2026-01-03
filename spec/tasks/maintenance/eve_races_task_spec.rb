# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveRacesTask do
  describe "#process" do
    before { expect(Eve::UpdateRacesJob).to receive(:perform_now) }

    specify { expect { subject.process }.not_to raise_error }
  end
end
