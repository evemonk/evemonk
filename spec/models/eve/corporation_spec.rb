# frozen_string_literal: true

require "rails_helper"

describe Eve::Corporation do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:search) }

  it { expect(described_class.table_name).to eq("eve_corporations") }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).optional(true) }

  it { should belong_to(:ceo).with_primary_key(:character_id).class_name("Eve::Character").optional(true) }

  it { should belong_to(:creator).with_primary_key(:character_id).class_name("Eve::Character").optional(true) }

  it { should belong_to(:faction).with_primary_key(:faction_id).optional(true) }

  it { should have_many(:corporation_alliance_histories).with_primary_key(:corporation_id) }

  describe "#search_data" do
    let!(:corporation) do
      create(:eve_corporation,
             name: "MyLittleDragon",
             ticker: "MYLID")
    end

    specify do
      expect(corporation.search_data).to eq(name: "MyLittleDragon",
                                            ticker: "MYLID")
    end
  end
end
