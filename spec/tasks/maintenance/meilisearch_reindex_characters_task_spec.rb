# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexCharactersTask do
  describe "#process" do
    before { expect(Eve::Character).to receive(:clear_index!).and_call_original }

    before { expect(Eve::Character).to receive(:reindex!).with(100).and_call_original }

    specify { expect { subject.process }.not_to raise_error }
  end
end
