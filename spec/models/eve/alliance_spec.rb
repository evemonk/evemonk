# frozen_string_literal: true

require "rails_helper"

describe Eve::Alliance do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:search) }

  it { expect(described_class.table_name).to eq("eve_alliances") }

  it { should belong_to(:creator_corporation).with_primary_key(:corporation_id).class_name("Eve::Corporation").optional }

  it { should belong_to(:creator).with_primary_key(:character_id).class_name("Eve::Character").optional }

  it { should belong_to(:executor_corporation).with_foreign_key(:executor_corporation_id).with_primary_key(:corporation_id).class_name("Eve::Corporation").optional }

  it { should belong_to(:faction).with_primary_key(:faction_id).optional }

  it { should have_many(:alliance_corporations).with_primary_key(:alliance_id) }

  it { should have_many(:corporations).through(:alliance_corporations) }

  describe "#characters_count" do
    let!(:alliance) { create(:eve_alliance, alliance_id: 123) }

    let!(:corporation1) { create(:eve_corporation, corporation_id: 124, alliance_id: 123, member_count: 123) }

    let!(:corporation2) { create(:eve_corporation, corporation_id: 125, alliance_id: 123, member_count: 123) }

    let!(:alliance_corporation1) { create(:eve_alliance_corporation, corporation_id: 124, alliance_id: 123) }

    let!(:alliance_corporation2) { create(:eve_alliance_corporation, corporation_id: 125, alliance_id: 123) }

    specify { expect(alliance.characters_count).to eq(246) }
  end

  describe "#search_data" do
    let!(:alliance) do
      create(:eve_alliance,
             name: "Kids With Guns Alliance",
             ticker: "-KWG-")
    end

    specify do
      expect(alliance.search_data).to eq(name: "Kids With Guns Alliance",
                                         ticker: "-KWG-")
    end
  end
end
