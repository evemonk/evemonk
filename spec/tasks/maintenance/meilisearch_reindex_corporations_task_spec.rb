# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexCorporationsTask do
  describe "#process" do
    before { expect(Eve::Corporation).to receive(:clear_index!).and_call_original }

    before { expect(Eve::Corporation).to receive(:reindex!).with(100).and_call_original }

    specify { expect { subject.process }.not_to raise_error }
  end
end
