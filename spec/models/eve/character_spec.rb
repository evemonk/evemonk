# frozen_string_literal: true

require "rails_helper"

describe Eve::Character do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:search) }

  it { expect(described_class.table_name).to eq("eve_characters") }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).optional(true) }

  it { should belong_to(:ancestry).with_primary_key(:ancestry_id).optional(true) }

  it { should belong_to(:bloodline).with_primary_key(:bloodline_id).optional(true) }

  it { should belong_to(:corporation).with_primary_key(:corporation_id).optional(true) }

  it { should belong_to(:faction).with_primary_key(:faction_id).optional(true) }

  it { should belong_to(:race).with_primary_key(:race_id).optional(true) }

  it { should have_many(:character_corporation_histories).with_primary_key(:character_id).dependent(:destroy) }

  describe "#search_data" do
    let!(:character) do
      create(:eve_character,
        name: "Green Black")
    end

    specify do
      expect(character.search_data).to eq(name: "Green Black")
    end
  end
end
