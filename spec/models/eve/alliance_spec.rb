# frozen_string_literal: true

require "rails_helper"

describe Eve::Alliance do
  it { should be_an(ApplicationRecord) }

  it { should be_a(PgSearch::Model) }

  it { should be_a(ActionView::Helpers::NumberHelper) }

  it { should be_a(ImageProxy) }

  it { should respond_to(:versions) }

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

  it { should have_one_attached(:logo) }

  it { should have_db_index([:name, :ticker]) }

  it { expect(described_class).to respond_to(:search_by_name_and_ticker) }

  describe "#reset_corporations_count" do
    let!(:eve_alliance) { create(:eve_alliance) }

    let!(:eve_corporation_1) { create(:eve_corporation, alliance: eve_alliance) }

    let!(:eve_corporation_2) { create(:eve_corporation, alliance: eve_alliance) }

    subject { eve_alliance }

    before { subject.update!(corporations_count: 0) }

    specify { expect { subject.reset_corporations_count }.to change { subject.corporations_count }.from(0).to(2) }
  end

  describe "#reset_characters_count" do
    let!(:eve_alliance) { create(:eve_alliance) }

    let!(:eve_corporation_1) { create(:eve_corporation, alliance: eve_alliance, member_count: 123) }

    let!(:eve_corporation_2) { create(:eve_corporation, alliance: eve_alliance, member_count: 123) }

    subject { eve_alliance }

    before { subject.update!(characters_count: 0) }

    specify { expect { subject.reset_characters_count }.to change { subject.characters_count }.from(0).to(246) }
  end

  describe "#icon_tiny" do
    subject do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_tiny).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=32") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_tiny).to eq("https://images.evetech.net/alliances/1354830081/logo?size=32") }
    end
  end

  describe "#icon_small" do
    subject do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_small).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=64") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_small).to eq("https://images.evetech.net/alliances/1354830081/logo?size=64") }
    end
  end

  describe "#icon_medium" do
    subject do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_medium).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=128") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_medium).to eq("https://images.evetech.net/alliances/1354830081/logo?size=128") }
    end
  end

  describe "#icon_large" do
    subject do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_large).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=256") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_large).to eq("https://images.evetech.net/alliances/1354830081/logo?size=256") }
    end
  end

  describe "#icon_huge" do
    subject do
      build(:eve_alliance,
        alliance_id: 1_354_830_081)
    end

    context "when Setting.use_image_proxy is true" do
      before { Setting.use_image_proxy = true }

      specify { expect(subject.icon_huge).to eq("https://imageproxy.evemonk.com/https://images.evetech.net/alliances/1354830081/logo?size=512") }
    end

    context "when Setting.use_image_proxy is false" do
      before { Setting.use_image_proxy = false }

      specify { expect(subject.icon_huge).to eq("https://images.evetech.net/alliances/1354830081/logo?size=512") }
    end
  end

  describe "#formatted_corporations_count" do
    context "when number is 3" do
      subject do
        build(:eve_alliance,
          corporations_count: 111)
      end

      specify { expect(subject.formatted_corporations_count).to eq("111") }
    end

    context "when number is 6" do
      subject do
        build(:eve_alliance,
          corporations_count: 111_222)
      end

      specify { expect(subject.formatted_corporations_count).to eq("111 222") }
    end
  end

  describe "#formatted_characters_count" do
    context "when number is 3" do
      subject do
        build(:eve_alliance,
          characters_count: 111)
      end

      specify { expect(subject.formatted_characters_count).to eq("111") }
    end

    context "when number is 6" do
      subject do
        build(:eve_alliance,
          characters_count: 111_222)
      end

      specify { expect(subject.formatted_characters_count).to eq("111 222") }
    end
  end
end
