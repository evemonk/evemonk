# frozen_string_literal: true

require "rails_helper"

describe CharacterAttributes do
  let!(:implant_1) { create(:eve_type, published: true) }

  let!(:implant_2) { create(:eve_type, published: true) }

  let!(:implant_3) { create(:eve_type, published: true) }

  let!(:implant_4) { create(:eve_type, published: true) }

  let!(:implant_5) { create(:eve_type, published: true) }

  let!(:character) do
    create(:character,
      perception: 20,
      memory: 21,
      willpower: 22,
      intelligence: 23,
      charisma: 24)
  end

  let!(:character_implant_1) do
    create(:character_implant,
      character: character,
      type_id: implant_1.id)
  end

  let!(:character_implant_2) do
    create(:character_implant,
      character: character,
      type_id: implant_2.id)
  end

  let!(:character_implant_3) do
    create(:character_implant,
      character: character,
      type_id: implant_3.id)
  end

  let!(:character_implant_4) do
    create(:character_implant,
      character: character,
      type_id: implant_4.id)
  end

  let!(:character_implant_5) do
    create(:character_implant,
      character: character,
      type_id: implant_5.id)
  end

  let!(:eve_dogma_attribute_1) do
    create(:eve_dogma_attribute,
      name: "perceptionBonus")
  end

  let!(:eve_dogma_attribute_2) do
    create(:eve_dogma_attribute,
      name: "memoryBonus")
  end

  let!(:eve_dogma_attribute_3) do
    create(:eve_dogma_attribute,
      name: "willpowerBonus")
  end

  let!(:eve_dogma_attribute_4) do
    create(:eve_dogma_attribute,
      name: "intelligenceBonus")
  end

  let!(:eve_dogma_attribute_5) do
    create(:eve_dogma_attribute,
      name: "charismaBonus")
  end

  let!(:eve_type_dogma_attribute_1) do
    create(:eve_type_dogma_attribute,
      type: implant_1,
      attribute_id: eve_dogma_attribute_1.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute_2) do
    create(:eve_type_dogma_attribute,
      type: implant_2,
      attribute_id: eve_dogma_attribute_2.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute_3) do
    create(:eve_type_dogma_attribute,
      type: implant_3,
      attribute_id: eve_dogma_attribute_3.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute_4) do
    create(:eve_type_dogma_attribute,
      type: implant_4,
      attribute_id: eve_dogma_attribute_4.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute_5) do
    create(:eve_type_dogma_attribute,
      type: implant_5,
      attribute_id: eve_dogma_attribute_5.attribute_id,
      value: 3.0)
  end

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#perception_without_bonuses" do
    specify { expect(subject.perception_without_bonuses).to eq(17) }
  end

  describe "#perception_bonus" do
    specify { expect(subject.perception_bonus).to eq(3.0) }
  end

  describe "#memory_without_bonuses" do
    specify { expect(subject.memory_without_bonuses).to eq(18) }
  end

  describe "#memory_bonus" do
    specify { expect(subject.memory_bonus).to eq(3.0) }
  end

  describe "#willpower_without_bonuses" do
    specify { expect(subject.willpower_without_bonuses).to eq(19) }
  end

  describe "#willpower_bonus" do
    specify { expect(subject.willpower_bonus).to eq(3.0) }
  end

  describe "#intelligence_without_bonuses" do
    specify { expect(subject.intelligence_without_bonuses).to eq(20) }
  end

  describe "#intelligence_bonus" do
    specify { expect(subject.intelligence_bonus).to eq(3.0) }
  end

  describe "#charisma_without_bonuses" do
    specify { expect(subject.charisma_without_bonuses).to eq(21) }
  end

  describe "#charisma_bonus" do
    specify { expect(subject.charisma_bonus).to eq(3.0) }
  end
end
