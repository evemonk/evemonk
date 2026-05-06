# frozen_string_literal: true

require "rails_helper"

RSpec.describe Meilisearch::Eve::ReindexCharacterJob, type: :job do
  it { expect(described_class.queue_name).to eq("meilisearch") }

  describe "#perform" do
    before { Meilisearch::Rails.activate! }

    after { Meilisearch::Rails.deactivate! }

    context "when adding to index" do
      let!(:eve_character) { create(:eve_character) }

      it { expect { described_class.new.perform(eve_character.id, false) }.not_to raise_error }
    end

    context "when removing from index" do
      let!(:eve_character) { create(:eve_character) }

      it { expect { described_class.new.perform(eve_character.id, true) }.not_to raise_error }
    end
  end
end
