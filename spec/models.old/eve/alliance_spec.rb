# frozen_string_literal: true

require "rails_helper"

describe Eve::Alliance do
  it { should be_an(ApplicationRecord) }

  it { should be_a(ImageProxy) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:search) }

  it { expect(described_class.table_name).to eq("eve_alliances") }

  it { should belong_to(:creator_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:creator).class_name("Eve::Character").with_primary_key("character_id").optional(true) }

  it { should belong_to(:executor_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").with_foreign_key("executor_corporation_id").optional(true) }

  it { should belong_to(:faction).with_primary_key("faction_id").optional(true) }

  it { should have_many(:corporations).with_primary_key("alliance_id") }

  it { should have_many(:characters).through(:corporations) }

  it { should have_many(:corporation_alliance_histories).with_primary_key("alliance_id") }

  it { should callback(:reset_corporations_count).after(:commit).on(:create) }

  it { should callback(:reset_characters_count).after(:commit).on(:create) }

  it { should have_db_index(:name) }

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

  describe "#reset_corporations_count" do
    let!(:eve_alliance) { create(:eve_alliance) }

    let!(:eve_corporation1) { create(:eve_corporation, alliance: eve_alliance) }

    let!(:eve_corporation2) { create(:eve_corporation, alliance: eve_alliance) }

    subject { eve_alliance }

    before { subject.update!(corporations_count: 0) }

    specify { expect { subject.reset_corporations_count }.to change { subject.corporations_count }.from(0).to(2) }
  end

  describe "#reset_characters_count" do
    let!(:eve_alliance) { create(:eve_alliance) }

    let!(:eve_corporation1) { create(:eve_corporation, alliance: eve_alliance, member_count: 123) }

    let!(:eve_corporation2) { create(:eve_corporation, alliance: eve_alliance, member_count: 123) }

    subject { eve_alliance }

    before { subject.update!(characters_count: 0) }

    specify { expect { subject.reset_characters_count }.to change { subject.characters_count }.from(0).to(246) }
  end
end
