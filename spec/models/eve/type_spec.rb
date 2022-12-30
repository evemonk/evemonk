# frozen_string_literal: true

require "rails_helper"

describe Eve::Type do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("type_id") }

  it { should be_a(PgSearch::Model) }

  it { should be_an(ActionView::Helpers::NumberHelper) }

  it { should be_a(Imageable) }

  specify { expect(described_class::PRIMARY_ATTRIBUTE_NAME).to eq("primaryAttribute") }

  specify { expect(described_class::SECONDARY_ATTRIBUTE_NAME).to eq("secondaryAttribute") }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_types") }

  it { should belong_to(:graphic).with_primary_key("graphic_id").optional(true) }

  it { should belong_to(:group).optional(true) }

  it { should belong_to(:icon).optional(true) }

  it { should belong_to(:market_group).optional(true) }

  it { should have_many(:type_dogma_attributes).with_primary_key("type_id").with_foreign_key("type_id").dependent(:destroy) }

  it { should have_many(:dogma_attributes).through(:type_dogma_attributes) }

  it { should have_many(:type_dogma_effects).with_primary_key("type_id").with_foreign_key("type_id").dependent(:destroy) }

  # it { should have_many(:dogma_effects).through(:type_dogma_effects) }

  describe ".published" do
    let!(:eve_type_1) { create(:eve_type, published: false) }

    let!(:eve_type_2) { create(:eve_type, published: true) }

    specify { expect(described_class.published.count).to eq(1) }

    specify { expect(described_class.published).to eq([eve_type_2]) }
  end

  describe ".blueprints" do
    let!(:eve_type_1) { create(:eve_type, is_blueprint: false) }

    let!(:eve_type_2) { create(:eve_type, is_blueprint: true) }

    specify { expect(described_class.blueprints.count).to eq(1) }

    specify { expect(described_class.blueprints).to eq([eve_type_2]) }
  end

  describe ".manufacturing_items" do
    let!(:eve_type_1) { create(:eve_type, is_manufacturing_item: false) }

    let!(:eve_type_2) { create(:eve_type, is_manufacturing_item: true) }

    specify { expect(described_class.manufacturing_items.count).to eq(1) }

    specify { expect(described_class.manufacturing_items).to eq([eve_type_2]) }
  end

  it { expect(described_class).to respond_to(:search_by_name) }

  describe "#implant_bonuses" do
    context "when @implant_bonuses is set" do
      let(:implant_bonuses) { double }

      before { subject.instance_variable_set(:@implant_bonuses, implant_bonuses) }

      specify { expect(subject.implant_bonuses).to eq(implant_bonuses) }
    end

    context "when @implant_bonuses is not set" do
      let(:implant_bonuses) { instance_double(Eve::ImplantBonuses) }

      let(:out) { double }

      before { expect(Eve::ImplantBonuses).to receive(:new).with(subject).and_return(implant_bonuses) }

      before { expect(implant_bonuses).to receive(:implant_bonuses).and_return(out) }

      specify { expect(subject.implant_bonuses).to eq(out) }

      specify { expect { subject.implant_bonuses }.to change { subject.instance_variable_get(:@implant_bonuses) }.from(nil).to(out) }
    end
  end

  describe "#primary_attribute" do
    context "when @primary_attribute is set" do
      let(:primary_attribute) { instance_double(Eve::DogmaAttribute) }

      before { subject.instance_variable_set(:@primary_attribute, primary_attribute) }

      specify { expect(subject.primary_attribute).to eq(primary_attribute) }
    end

    context "when @primary_attribute is not set" do
      let!(:eve_type) { create(:eve_type, type_id: 33_078) }

      let!(:eve_dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 180, name: described_class::PRIMARY_ATTRIBUTE_NAME) }

      let!(:eve_type_dogma_attribute) { create(:eve_type_dogma_attribute, attribute_id: 180, type_id: 33_078, value: 165.0) }

      let!(:primary_attribute) { create(:eve_dogma_attribute, attribute_id: 165, name: "intelligence") }

      subject { eve_type }

      specify { expect(subject.primary_attribute).to eq(primary_attribute) }
    end
  end

  describe "#secondary_attribute" do
    context "when @secondary_attribute is set" do
      let(:secondary_attribute) { instance_double(Eve::DogmaAttribute) }

      before { subject.instance_variable_set(:@secondary_attribute, secondary_attribute) }

      specify { expect(subject.secondary_attribute).to eq(secondary_attribute) }
    end

    context "when @secondary_attribute is not set" do
      let!(:eve_type) { create(:eve_type, type_id: 33_078) }

      let!(:eve_dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 180, name: described_class::SECONDARY_ATTRIBUTE_NAME) }

      let!(:eve_type_dogma_attribute) { create(:eve_type_dogma_attribute, attribute_id: 180, type_id: 33_078, value: 166.0) }

      let!(:secondary_attribute) { create(:eve_dogma_attribute, attribute_id: 166, name: "memory") }

      subject { eve_type }

      specify { expect(subject.secondary_attribute).to eq(secondary_attribute) }
    end
  end

  describe "#icon_tiny" do
    before { expect(subject).to receive(:type_icon_url).with(32) }

    specify { expect { subject.icon_tiny }.not_to raise_error }
  end

  describe "#icon_small" do
    before { expect(subject).to receive(:type_icon_url).with(64) }

    specify { expect { subject.icon_small }.not_to raise_error }
  end

  describe "#render_tiny" do
    before { expect(subject).to receive(:type_render_url).with(32) }

    specify { expect { subject.render_tiny }.not_to raise_error }
  end

  describe "#render_small" do
    before { expect(subject).to receive(:type_render_url).with(64) }

    specify { expect { subject.render_small }.not_to raise_error }
  end

  describe "#render_medium" do
    before { expect(subject).to receive(:type_render_url).with(128) }

    specify { expect { subject.render_medium }.not_to raise_error }
  end

  describe "#render_large" do
    before { expect(subject).to receive(:type_render_url).with(256) }

    specify { expect { subject.render_large }.not_to raise_error }
  end

  describe "#render_huge" do
    before { expect(subject).to receive(:type_render_url).with(512) }

    specify { expect { subject.render_huge }.not_to raise_error }
  end

  describe "#relic_tiny" do
    before { expect(subject).to receive(:type_relic_url).with(32) }

    specify { expect { subject.relic_tiny }.not_to raise_error }
  end

  describe "#relic_small" do
    before { expect(subject).to receive(:type_relic_url).with(64) }

    specify { expect { subject.relic_small }.not_to raise_error }
  end

  describe "#average_price_formatted" do
    context "when average_price is empty" do
      subject do
        build(:eve_type,
          average_price: nil)
      end

      specify { expect(subject.average_price_formatted).to eq("0") }
    end

    context "when average_price is present" do
      subject do
        build(:eve_type,
          average_price: 9_061_680)
      end

      specify { expect(subject.average_price_formatted).to eq("9 061 680") }
    end
  end

  # private methods

  describe "#type_icon_url" do
    subject { build(:eve_type, type_id: 23_773) }

    before do
      #
      # imageable_url("types", type_id, "icon", size)
      #
      expect(subject).to receive(:imageable_url).with("types", 23_773, "icon", 32)
    end

    specify { expect { subject.send(:type_icon_url, 32) }.not_to raise_error }
  end

  describe "#type_render_url" do
    subject { build(:eve_type, type_id: 23_773) }

    before do
      #
      # imageable_url("types", type_id, "render", size)
      #
      expect(subject).to receive(:imageable_url).with("types", 23_773, "render", 64)
    end

    specify { expect { subject.send(:type_render_url, 64) }.not_to raise_error }
  end

  describe "#type_relic_url" do
    subject { build(:eve_type, type_id: 23_773) }

    before do
      #
      # imageable_url("types", type_id, "portrait", size)
      #
      expect(subject).to receive(:imageable_url).with("types", 23_773, "relic", 32)
    end

    specify { expect { subject.send(:type_relic_url, 32) }.not_to raise_error }
  end
end
