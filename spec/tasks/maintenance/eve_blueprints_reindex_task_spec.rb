# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::EveBlueprintsReindexTask do
  describe "#process" do
    before { expect(Eve::Blueprint).to receive(:reindex!).and_call_original }

    specify { expect { subject.process }.not_to raise_error }
  end
end
