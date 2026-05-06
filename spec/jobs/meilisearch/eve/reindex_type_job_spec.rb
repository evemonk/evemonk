# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meilisearch::Eve::ReindexTypeJob, type: :job do
  it { expect(described_class.queue_name).to eq("meilisearch") }

  describe "#perform" do
    before { Meilisearch::Rails.activate! }

    after { Meilisearch::Rails.deactivate! }

    context "when adding to index" do
      let!(:eve_type) { create(:eve_type) }

      it { expect { described_class.new.perform(eve_type.id, false) }.not_to raise_error }
    end

    context "when removing from index" do
      let!(:eve_type) { create(:eve_type) }

      it { expect { described_class.new.perform(eve_type.id, true) }.not_to raise_error }
    end
  end
end
