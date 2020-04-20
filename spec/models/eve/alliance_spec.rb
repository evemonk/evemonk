# frozen_string_literal: true

require "rails_helper"

describe Eve::Alliance do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:search) }

  it { expect(described_class.table_name).to eq("eve_alliances") }

  it { should belong_to(:creator_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:creator).class_name("Eve::Character").with_primary_key("character_id").optional(true) }

  it { should belong_to(:executor_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").with_foreign_key("executor_corporation_id").optional(true) }

  it { should belong_to(:faction).with_primary_key("faction_id").optional(true) }

  it { should have_many(:alliance_corporations).with_primary_key("alliance_id") }

  it { should have_many(:corporations).through(:alliance_corporations) }

  it { should have_many(:characters).through(:corporations) }

  it { should have_many(:corporation_alliance_histories).with_primary_key("alliance_id") }

  it { should callback(:reset_characters_count).after(:commit).on(:create) }

  describe "#search_data" do
    let!(:eve_alliance) do
      create(:eve_alliance,
        name: "Kids With Guns Alliance",
        ticker: "-KWG-")
    end

    specify do
      expect(eve_alliance.search_data).to eq(name: "Kids With Guns Alliance",
                                             ticker: "-KWG-")
    end
  end

  describe "#reset_characters_count" do
    let!(:eve_alliance) { create(:eve_alliance, alliance_id: 12_345) }

    let!(:eve_alliance_corporation1) { create(:eve_alliance_corporation, alliance_id: 12_345, corporation_id: 123) }

    let!(:eve_alliance_corporation2) { create(:eve_alliance_corporation, alliance_id: 12_345, corporation_id: 321) }

    let!(:eve_corporation1) { create(:eve_corporation, corporation_id: 123, alliance_id: 12_345, member_count: 123) }

    let!(:eve_corporation2) { create(:eve_corporation, corporation_id: 321, alliance_id: 12_345, member_count: 123) }

    subject { eve_alliance }

    before { subject.update!(characters_count: 0) }

    specify { expect { subject.reset_characters_count }.to change { subject.characters_count }.from(0).to(246) }
  end
end
