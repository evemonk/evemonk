# frozen_string_literal: true

require "rails_helper"

describe CharacterAttributes do
  let!(:character) do
    create(:character,
      perception: 23,
      memory: 24,
      willpower: 23,
      intelligence: 24,
      charisma: 20)
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
