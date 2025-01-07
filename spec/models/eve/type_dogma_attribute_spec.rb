# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::TypeDogmaAttribute, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(subject).to be_an(ActionView::Helpers::NumberHelper) }

  it { expect(described_class.table_name).to eq("eve_type_dogma_attributes") }

  it { expect(subject).to belong_to(:type).optional }

  it { expect(subject).to belong_to(:dogma_attribute).with_primary_key("attribute_id").with_foreign_key("attribute_id").optional }

  describe "#value_with_unit" do
    describe "#when dogma attribute without unit" do
      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: nil) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1.0) }

      specify { expect(subject.value_with_unit).to eq(1) }
    end

    describe "when dogma attribute unit name is attributePoints" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "attributePoints") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1.0) }

      specify { expect(subject.value_with_unit).to eq("1 points") }
    end

    describe "when dogma attribute unit name is Slot" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Slot") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1.0) }

      specify { expect(subject.value_with_unit).to eq("Slot 1") }
    end

    describe "when dogma attribute unit name is Level" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Level") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1.0) }

      specify { expect(subject.value_with_unit).to eq("Level 1") }
    end

    describe "when dogma attribute unit name is Volume" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Volume") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1.0) }

      specify { expect(subject.value_with_unit).to eq("1 &#13221;") }
    end

    describe "when dogma attribute unit name is Hitpoints" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Hitpoints") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1_000.0) }

      specify { expect(subject.value_with_unit).to eq("1 000 HP") }
    end

    describe "when dogma attribute unit name is Mass" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Mass") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1_000.0) }

      specify { expect(subject.value_with_unit).to eq("1 000 kg") }
    end

    describe "when dogma attribute unit name is Percentage" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Percentage") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 5.0) }

      specify { expect(subject.value_with_unit).to eq("5 %") }
    end

    describe "when dogma attribute unit name is not listed" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Other") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1.0) }

      specify { expect(subject.value_with_unit).to eq("1 Other") }
    end
  end
end
