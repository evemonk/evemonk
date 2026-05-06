# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexTypesTask do
  describe "#collection" do
    let!(:eve_type) { create(:eve_type) }

    specify { expect(subject.collection).to eq([eve_type]) }
  end

  describe "#process" do
    let!(:eve_type) { create(:eve_type) }

    before { expect(Meilisearch::Eve::ReindexTypeJob).to receive(:perform_later).with(eve_type.id, false) }

    specify { expect { subject.process(eve_type) }.not_to raise_error }
  end
end
