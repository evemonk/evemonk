# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexCorporationsTask do
  describe "#collection" do
    let!(:eve_corporation) { create(:eve_corporation) }

    specify { expect(subject.collection).to eq([eve_corporation]) }
  end

  describe "#process" do
    let!(:eve_corporation) { create(:eve_corporation) }

    before { expect(Meilisearch::Eve::ReindexCorporationJob).to receive(:perform_later).with(eve_corporation.id, false) }

    specify { expect { subject.process(eve_corporation) }.not_to raise_error }
  end
end
