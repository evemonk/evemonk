# frozen_string_literal: true

require "rails_helper"

describe Eve::Corporation do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:search) }

  it { expect(described_class.table_name).to eq("eve_corporations") }

  it { should belong_to(:alliance).with_primary_key("alliance_id").optional(true) }

  it { should belong_to(:ceo).with_primary_key("character_id").class_name("Eve::Character").optional(true) }

  it { should belong_to(:creator).with_primary_key("character_id").class_name("Eve::Character").optional(true) }

  it { should belong_to(:faction).with_primary_key("faction_id").optional(true) }

  it { should belong_to(:home_station).class_name("Eve::Station").with_primary_key("station_id").with_foreign_key("home_station_id").optional(true) }

  it { should have_many(:characters).with_primary_key("corporation_id") }

  it { should have_many(:corporation_alliance_histories).with_primary_key("corporation_id") }

  it { should have_many(:standings) }

  it { should have_many(:loyalty_store_offers).with_primary_key("corporation_id") }

  it { should have_db_index(:name) }

  describe ".npc" do
    let!(:eve_corporation1) { create(:eve_corporation, npc: false) }

    let!(:eve_corporation2) { create(:eve_corporation, npc: true) }

    specify { expect(described_class.npc.count).to eq(1) }

    specify { expect(described_class.npc).to eq([eve_corporation2]) }
  end

  describe ".not_npc" do
    let!(:eve_corporation1) { create(:eve_corporation, npc: false) }

    let!(:eve_corporation2) { create(:eve_corporation, npc: true) }

    specify { expect(described_class.not_npc.count).to eq(1) }

    specify { expect(described_class.not_npc).to eq([eve_corporation1]) }
  end

  it { should callback(:eve_alliance_reset_characters_count).after(:commit).on([:create, :update, :destroy]) }

  describe "#search_data" do
    let!(:eve_corporation) do
      create(:eve_corporation,
        name: "MyLittleDragon",
        ticker: "MYLID")
    end

    specify do
      expect(eve_corporation.search_data).to eq(name: "MyLittleDragon",
                                                ticker: "MYLID")
    end
  end

  describe "#eve_alliance_reset_characters_count" do
    context "when alliance exists" do
      let!(:eve_alliance) { create(:eve_alliance) }

      let!(:eve_corporation) { create(:eve_corporation, alliance: eve_alliance) }

      let!(:eve_alliance_corporation) { create(:eve_alliance_corporation, alliance: eve_alliance, corporation: eve_corporation) }

      subject { eve_corporation }

      before { expect(eve_alliance).to receive(:reset_characters_count) }

      specify { expect { subject.eve_alliance_reset_characters_count }.not_to raise_error }
    end

    context "when alliance not exists" do
      let!(:eve_corporation) { create(:eve_corporation) }

      subject { eve_corporation }

      specify { expect { subject.eve_alliance_reset_characters_count }.not_to raise_error }
    end
  end
end
