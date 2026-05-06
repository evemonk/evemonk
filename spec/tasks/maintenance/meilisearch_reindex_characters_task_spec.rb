# frozen_string_literal: true

require "rails_helper"

RSpec.describe Maintenance::MeilisearchReindexCharactersTask do
  describe "#collection" do
    let!(:eve_character) { create(:eve_character) }

    specify { expect(subject.collection).to eq([eve_character]) }
  end

  describe "#process" do
    let!(:eve_character) { create(:eve_character) }

    before { expect(Meilisearch::Eve::ReindexCharacterJob).to receive(:perform_later).with(eve_character.id, false) }

    specify { expect { subject.process(eve_character) }.not_to raise_error }
  end
end
