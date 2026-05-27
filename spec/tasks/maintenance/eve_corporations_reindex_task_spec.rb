# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveCorporationsReindexTask do
  describe "#process" do
    before { expect(Eve::Corporation).to receive(:reindex!).and_call_original }

    specify { expect { subject.process }.not_to raise_error }
  end
end
