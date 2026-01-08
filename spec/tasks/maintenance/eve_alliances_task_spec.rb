# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveAlliancesTask do
  describe "#process" do
    before { expect(Eve::UpdateAlliancesJob).to receive(:perform_later) }

    specify { expect { subject.process }.not_to raise_error }
  end
end
