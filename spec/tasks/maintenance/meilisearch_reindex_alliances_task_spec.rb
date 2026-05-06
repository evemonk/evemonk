# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexAlliancesTask do
  describe "#process" do
    let!(:alliance) { create(:eve_alliance) }

    before { expect(Meilisearch::Eve::ReindexAllianceJob).to receive(:perform_later).with(alliance.id, false) }

    specify { expect { subject.process(alliance) }.not_to raise_error }
  end
end
