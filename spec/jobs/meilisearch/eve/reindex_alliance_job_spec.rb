# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meilisearch::Eve::ReindexAllianceJob, type: :job do
  it { expect(described_class.queue_name).to eq("meilisearch") }

  describe "#perform" do
    context "when adding to index" do
      let!(:eve_alliance) { create(:eve_alliance) }

      it { expect { described_class.new.perform(eve_alliance.id, false) }.not_to raise_error }
    end

    context "when removing from index" do
      let!(:eve_alliance) { create(:eve_alliance) }

      it { expect { described_class.new.perform(eve_alliance.id, true) }.not_to raise_error }
    end
  end
end
