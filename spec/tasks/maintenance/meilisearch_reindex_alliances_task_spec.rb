# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexAlliancesTask do
  describe "#process" do
    let!(:alliance) { create(:eve_alliance) }

    before { expect(Eve::Alliance).to receive(:clear_index!).and_call_original }

    before { expect(Meilisearch::Rails::MSJob).to receive(:perform_later).with(alliance, :index!).and_call_original }

    # Meilisearch::Rails::MSJob.perform_later(alliance, :index!)
    #
    # before { expect(Eve::Alliance).to receive(:reindex!).with(100).and_call_original }

    specify { expect { subject.process }.not_to raise_error }
  end
end
