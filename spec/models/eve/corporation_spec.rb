# frozen_string_literal: true

require "rails_helper"

describe Eve::Corporation do
  it { should be_an(ApplicationRecord) }

  it { should be_a(PgSearch::Model) }

  it { should be_an(ActionView::Helpers::NumberHelper) }

  it { should be_an(Imageable) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_corporations") }

  it { should belong_to(:alliance).optional(true) }

  it { should belong_to(:ceo).class_name("Eve::Character").optional(true) }

  it { should belong_to(:creator).class_name("Eve::Character").optional(true) }

  it { should belong_to(:faction).with_primary_key("faction_id").optional(true) }

  it { should belong_to(:home_station).class_name("Eve::Station").with_primary_key("station_id").with_foreign_key("home_station_id").optional(true) }

  it { should have_many(:characters).with_primary_key("corporation_id") }

  it { should have_many(:corporation_alliance_histories).with_primary_key("corporation_id") }

  it { should have_many(:standings) }

  it { should have_many(:loyalty_store_offers).with_primary_key("corporation_id") }

  it { should have_one_attached(:logo) }

  it { should have_db_index([:name, :ticker]) }

  describe ".npc" do
    let!(:eve_corporation_1) { create(:eve_corporation, npc: false) }

    let!(:eve_corporation_2) { create(:eve_corporation, npc: true) }

    specify { expect(described_class.npc.count).to eq(1) }

    specify { expect(described_class.npc).to eq([eve_corporation_2]) }
  end

  describe ".not_npc" do
    let!(:eve_corporation_1) { create(:eve_corporation, npc: false) }

    let!(:eve_corporation_2) { create(:eve_corporation, npc: true) }

    specify { expect(described_class.not_npc.count).to eq(1) }

    specify { expect(described_class.not_npc).to eq([eve_corporation_1]) }
  end

  it { should callback(:eve_alliance_reset_corporations_count).after(:commit).on([:create, :update, :destroy]) }

  it { should callback(:eve_alliance_reset_characters_count).after(:commit).on([:create, :update, :destroy]) }

  it { expect(described_class).to respond_to(:search_by_name_and_ticker) }

  describe "#eve_alliance_reset_corporations_count" do
    context "when alliance exists" do
      let!(:eve_alliance) { create(:eve_alliance) }

      let!(:eve_corporation) { create(:eve_corporation, alliance: eve_alliance) }

      subject { eve_corporation }

      before { expect(eve_alliance).to receive(:reset_corporations_count) }

      specify { expect { subject.eve_alliance_reset_corporations_count }.not_to raise_error }
    end

    context "when alliance not exists" do
      let!(:eve_corporation) { create(:eve_corporation) }

      subject { eve_corporation }

      specify { expect { subject.eve_alliance_reset_corporations_count }.not_to raise_error }
    end
  end

  describe "#eve_alliance_reset_characters_count" do
    context "when alliance exists" do
      let!(:eve_alliance) { create(:eve_alliance) }

      let!(:eve_corporation) { create(:eve_corporation, alliance: eve_alliance) }

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

  describe "#icon_tiny" do
    before { expect(subject).to receive(:corporation_logo_url).with(32) }

    specify { expect { subject.icon_tiny }.not_to raise_error }
  end

  describe "#icon_small" do
    before { expect(subject).to receive(:corporation_logo_url).with(64) }

    specify { expect { subject.icon_small }.not_to raise_error }
  end

  describe "#icon_medium" do
    before { expect(subject).to receive(:corporation_logo_url).with(128) }

    specify { expect { subject.icon_medium }.not_to raise_error }
  end

  describe "#icon_large" do
    before { expect(subject).to receive(:corporation_logo_url).with(256) }

    specify { expect { subject.icon_large }.not_to raise_error }
  end

  describe "#formatted_member_count" do
    context "when number is 3" do
      subject do
        build(:eve_corporation,
          member_count: 111)
      end

      specify { expect(subject.formatted_member_count).to eq("111") }
    end

    context "when number is 6" do
      subject do
        build(:eve_corporation,
          member_count: 111_222)
      end

      specify { expect(subject.formatted_member_count).to eq("111,222") }
    end
  end

  describe "#sanitized_description" do
    subject do
      build(:eve_corporation,
        description: "<b>Test</b>")
    end

    specify { expect(subject.sanitized_description).to eq("Test") }
  end

  describe "#to_key" do
    context "when corporation_id is present" do
      subject { build(:eve_corporation, corporation_id: 1_344_654_522) }

      specify { expect(subject.to_key).to eq([1_344_654_522]) }
    end

    context "when corporation_id is not present" do
      subject { build(:eve_corporation, corporation_id: nil) }

      specify { expect(subject.to_key).to eq(nil) }
    end
  end

  describe "#to_param" do
    context "when corporation_id is present" do
      subject { build(:eve_corporation, corporation_id: 1_344_654_522) }

      specify { expect(subject.to_param).to eq("1344654522") }
    end

    context "when corporation_id is not present" do
      subject { build(:eve_corporation, corporation_id: nil) }

      specify { expect(subject.to_param).to eq(nil) }
    end
  end

  # private methods

  describe "#alliance_logo_url" do
    subject { build(:eve_corporation, corporation_id: 1_344_654_522) }

    before do
      #
      # imageable_url("corporations", corporation_id, "logo", size)
      #
      expect(subject).to receive(:imageable_url).with("corporations", 1_344_654_522, "logo", 256)
    end

    specify { expect { subject.send(:corporation_logo_url, 256) }.not_to raise_error }
  end
end
