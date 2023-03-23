# frozen_string_literal: true

require "rails_helper"

describe Eve::Alliance do
  it { should be_an(ApplicationRecord) }

  it { should be_a(PgSearch::Model) }

  it { should be_a(ActionView::Helpers::NumberHelper) }

  it { should be_a(Imageable) }

  it { expect(described_class.table_name).to eq("eve_alliances") }

  it { should belong_to(:creator_corporation).class_name("Eve::Corporation").optional(true) }

  it { should belong_to(:creator).class_name("Eve::Character").optional(true) }

  it { should belong_to(:executor_corporation).class_name("Eve::Corporation").optional(true) }

  it { should belong_to(:faction).optional(true) }

  it { should have_many(:corporations) }

  it { should have_many(:characters).through(:corporations) }

  it { should have_many(:corporation_alliance_histories) }

  # it { should callback(:reset_corporations_count).after(:commit).on(:create) }
  #
  # it { should callback(:reset_characters_count).after(:commit).on(:create) }

  it { should have_one_attached(:logo) }

  it { should have_db_index([:name, :ticker]) }

  it { expect(described_class).to respond_to(:search_by_name_and_ticker) }

  # describe "#reset_corporations_count" do
  #   let!(:eve_alliance) { create(:eve_alliance) }
  #
  #   let!(:eve_corporation_1) { create(:eve_corporation, alliance: eve_alliance) }
  #
  #   let!(:eve_corporation_2) { create(:eve_corporation, alliance: eve_alliance) }
  #
  #   subject { eve_alliance }
  #
  #   before { subject.update!(corporations_count: 0) }
  #
  #   specify { expect { subject.reset_corporations_count }.to change { subject.corporations_count }.from(0).to(2) }
  # end

  # describe "#reset_characters_count" do
  #   let!(:eve_alliance) { create(:eve_alliance) }
  #
  #   let!(:eve_corporation_1) { create(:eve_corporation, alliance: eve_alliance, member_count: 123) }
  #
  #   let!(:eve_corporation_2) { create(:eve_corporation, alliance: eve_alliance, member_count: 123) }
  #
  #   subject { eve_alliance }
  #
  #   before { subject.update!(characters_count: 0) }
  #
  #   specify { expect { subject.reset_characters_count }.to change { subject.characters_count }.from(0).to(246) }
  # end

  describe "#icon_tiny" do
    before { expect(subject).to receive(:alliance_logo_url).with(32) }

    specify { expect { subject.icon_tiny }.not_to raise_error }
  end

  describe "#icon_small" do
    before { expect(subject).to receive(:alliance_logo_url).with(64) }

    specify { expect { subject.icon_small }.not_to raise_error }
  end

  describe "#icon_medium" do
    before { expect(subject).to receive(:alliance_logo_url).with(128) }

    specify { expect { subject.icon_medium }.not_to raise_error }
  end

  describe "#icon_large" do
    before { expect(subject).to receive(:alliance_logo_url).with(256) }

    specify { expect { subject.icon_large }.not_to raise_error }
  end

  describe "#icon_huge" do
    before { expect(subject).to receive(:alliance_logo_url).with(512) }

    specify { expect { subject.icon_huge }.not_to raise_error }
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

  # private methods

  describe "#alliance_logo_url" do
    subject { build(:eve_alliance, id: 1_354_830_081) }

    before do
      #
      # imageable_url("alliances", id, "logo", size)
      #
      expect(subject).to receive(:imageable_url).with("alliances", 1_354_830_081, "logo", 512)
    end

    specify { expect { subject.send(:alliance_logo_url, 512) }.not_to raise_error }
  end
end
