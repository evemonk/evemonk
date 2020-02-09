# frozen_string_literal: true

require "rails_helper"

describe CharacterAttributes do
  let!(:implant1) { create(:eve_type, published: true) }

  let!(:implant2) { create(:eve_type, published: true) }

  let!(:implant3) { create(:eve_type, published: true) }

  let!(:implant4) { create(:eve_type, published: true) }

  let!(:implant5) { create(:eve_type, published: true) }

  let!(:character) do
    create(:character,
      perception: 23,
      memory: 24,
      willpower: 23,
      intelligence: 24,
      charisma: 20)
  end

  let!(:character_implant1) do
    create(:character_implant,
      character: character,
      type_id: implant1.type_id)
  end

  let!(:character_implant2) do
    create(:character_implant,
      character: character,
      type_id: implant2.type_id)
  end

  let!(:character_implant3) do
    create(:character_implant,
      character: character,
      type_id: implant3.type_id)
  end

  let!(:character_implant4) do
    create(:character_implant,
      character: character,
      type_id: implant4.type_id)
  end

  let!(:character_implant5) do
    create(:character_implant,
      character: character,
      type_id: implant5.type_id)
  end

  let!(:eve_dogma_attribute1) do
    create(:eve_dogma_attribute,
      name: "perceptionBonus")
  end

  let!(:eve_dogma_attribute2) do
    create(:eve_dogma_attribute,
      name: "memoryBonus")
  end

  let!(:eve_dogma_attribute3) do
    create(:eve_dogma_attribute,
      name: "willpowerBonus")
  end

  let!(:eve_dogma_attribute4) do
    create(:eve_dogma_attribute,
      name: "intelligenceBonus")
  end

  let!(:eve_dogma_attribute5) do
    create(:eve_dogma_attribute,
      name: "charismaBonus")
  end

  let!(:eve_type_dogma_attribute1) do
    create(:eve_type_dogma_attribute,
      type: implant1,
      attribute_id: eve_dogma_attribute1.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute2) do
    create(:eve_type_dogma_attribute,
      type: implant2,
      attribute_id: eve_dogma_attribute2.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute3) do
    create(:eve_type_dogma_attribute,
      type: implant3,
      attribute_id: eve_dogma_attribute3.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute4) do
    create(:eve_type_dogma_attribute,
      type: implant4,
      attribute_id: eve_dogma_attribute4.attribute_id,
      value: 3.0)
  end

  let!(:eve_type_dogma_attribute5) do
    create(:eve_type_dogma_attribute,
      type: implant5,
      attribute_id: eve_dogma_attribute5.attribute_id,
      value: 3.0)
  end

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#total_perception" do
    specify { expect(subject.total_perception).to eq(26) }
  end

  describe "#perception_bonus" do
    specify { expect(subject.perception_bonus).to eq(3.0) }
  end

  describe "#total_memory" do
    specify { expect(subject.total_memory).to eq(27) }
  end

  describe "#memory_bonus" do
    specify { expect(subject.memory_bonus).to eq(3.0) }
  end

  describe "#total_willpower" do
    specify { expect(subject.total_willpower).to eq(26) }
  end

  describe "#willpower_bonus" do
    specify { expect(subject.willpower_bonus).to eq(3.0) }
  end

  describe "#total_intelligence" do
    specify { expect(subject.total_intelligence).to eq(27) }
  end

  describe "#intelligence_bonus" do
    specify { expect(subject.intelligence_bonus).to eq(3.0) }
  end

  describe "#total_charisma" do
    specify { expect(subject.total_charisma).to eq(23) }
  end

  describe "#charisma_bonus" do
    specify { expect(subject.charisma_bonus).to eq(3.0) }
  end
end
