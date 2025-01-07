# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveAncestriesTask do
  describe "#process" do
    before { expect(Eve::UpdateAncestriesJob).to receive(:perform_later) }

    specify { expect { subject.process }.not_to raise_error }
  end
end
