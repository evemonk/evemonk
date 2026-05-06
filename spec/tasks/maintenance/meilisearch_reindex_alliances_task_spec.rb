# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexAlliancesTask do
  describe "#collection" do
    let!(:eve_alliance) { create(:eve_alliance) }

    specify { expect(subject.collection).to eq([eve_alliance]) }
  end

  describe "#process" do
    let!(:eve_alliance) { create(:eve_alliance) }

    before { expect(Meilisearch::Eve::ReindexAllianceJob).to receive(:perform_later).with(eve_alliance.id, false) }

    specify { expect { subject.process(eve_alliance) }.not_to raise_error }
  end
end
