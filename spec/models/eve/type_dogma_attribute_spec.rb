# frozen_string_literal: true

require "rails_helper"

describe Eve::TypeDogmaAttribute do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_type_dogma_attributes") }

  it { should belong_to(:type).with_primary_key("type_id").with_foreign_key("type_id").optional(true) }

  it { should belong_to(:dogma_attribute).with_primary_key("attribute_id").with_foreign_key("attribute_id").optional(true) }

  describe "#value_with_unit" do
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

    describe "when dogma attribute unit name is not listed" do
      let!(:eve_unit) { create(:eve_unit, unit_name: "Other") }

      let!(:dogma_attribute) { create(:eve_dogma_attribute, attribute_id: 1, unit_id: eve_unit.id) }

      subject { create(:eve_type_dogma_attribute, attribute_id: dogma_attribute.attribute_id, value: 1.0) }

      specify { expect(subject.value_with_unit).to eq("1 Other") }
    end
  end
end
