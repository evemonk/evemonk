# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveFactionsTask do
  describe "#process" do
    before { expect(Eve::UpdateFactionsJob).to receive(:perform_later) }

    specify { expect { subject.process }.not_to raise_error }
  end
end
