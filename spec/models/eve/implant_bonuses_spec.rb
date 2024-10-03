# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::ImplantBonuses do
  specify do
    expect(described_class::DOGMA_ATTRIBUTE_NAMES).to eq([
      "perceptionBonus",
      "memoryBonus",
      "willpowerBonus",
      "intelligenceBonus",
      "charismaBonus"
    ])
  end

  let!(:eve_dogma_attribute_1) do
    create(:eve_dogma_attribute,
      name: "perceptionBonus",
      display_name: "Perception Modifier",
      attribute_id: 101)
  end

  let!(:eve_dogma_attribute_2) do
    create(:eve_dogma_attribute,
      name: "memoryBonus",
      display_name: "Memory Modifier",
      attribute_id: 102)
  end

  let!(:eve_dogma_attribute_3) do
    create(:eve_dogma_attribute,
      name: "willpowerBonus",
      display_name: "Willpower Modifier",
      attribute_id: 103)
  end

  let!(:eve_dogma_attribute_4) do
    create(:eve_dogma_attribute,
      name: "intelligenceBonus",
      display_name: "Intelligence Modifier",
      attribute_id: 104)
  end

  let!(:eve_dogma_attribute_5) do
    create(:eve_dogma_attribute,
      name: "charismaBonus",
      display_name: "Charisma Modifier",
      attribute_id: 105)
  end

  let!(:implant) { create(:eve_type) }

  let!(:type_dogma_attribute_1) do
    create(:eve_type_dogma_attribute,
      type: implant,
      attribute_id: eve_dogma_attribute_1.attribute_id,
      value: 3.0)
  end

  let!(:type_dogma_attribute_2) do
    create(:eve_type_dogma_attribute,
      type: implant,
      attribute_id: eve_dogma_attribute_2.attribute_id,
      value: 3.0)
  end

  let!(:type_dogma_attribute_3) do
    create(:eve_type_dogma_attribute,
      type: implant,
      attribute_id: eve_dogma_attribute_3.attribute_id,
      value: 3.0)
  end

  let!(:type_dogma_attribute_4) do
    create(:eve_type_dogma_attribute,
      type: implant,
      attribute_id: eve_dogma_attribute_4.attribute_id,
      value: 3.0)
  end

  let!(:type_dogma_attribute_5) do
    create(:eve_type_dogma_attribute,
      type: implant,
      attribute_id: eve_dogma_attribute_5.attribute_id,
      value: 3.0)
  end

  subject { described_class.new(implant) }

  describe "#initialize" do
    its(:implant) { is_expected.to eq(implant) }
  end

  describe "#implant_bonuses" do
    specify do
      expect(subject.implant_bonuses).to eq([
        {name: "Perception Modifier", value: 3.0},
        {name: "Memory Modifier", value: 3.0},
        {name: "Willpower Modifier", value: 3.0},
        {name: "Intelligence Modifier", value: 3.0},
        {name: "Charisma Modifier", value: 3.0}
      ])
    end
  end

  # private methods

  describe "#attribute_ids" do
    specify { expect(subject.send(:attribute_ids)).to eq([101, 102, 103, 104, 105]) }
  end
end
