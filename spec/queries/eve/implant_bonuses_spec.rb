# frozen_string_literal: true

require "rails_helper"

describe Eve::ImplantBonuses do
  specify { expect(described_class::DOGMA_ATTRIBUTE_NAMES).to eq(["perceptionBonus",
                                                                  "memoryBonus",
                                                                  "willpowerBonus",
                                                                  "intelligenceBonus",
                                                                  "charismaBonus"]) }

  let!(:eve_dogma_attribute1) do
    create(:eve_dogma_attribute,
      name: "perceptionBonus",
      attribute_id: 101)
  end

  let!(:eve_dogma_attribute2) do
    create(:eve_dogma_attribute,
      name: "memoryBonus",
      attribute_id: 102)
  end

  let!(:eve_dogma_attribute3) do
    create(:eve_dogma_attribute,
      name: "willpowerBonus",
      attribute_id: 103)
  end

  let!(:eve_dogma_attribute4) do
    create(:eve_dogma_attribute,
      name: "intelligenceBonus",
      attribute_id: 104)
  end

  let!(:eve_dogma_attribute5) do
    create(:eve_dogma_attribute,
      name: "charismaBonus",
      attribute_id: 105)
  end

  let!(:implant) { create(:eve_type) }

  subject { described_class.new(implant) }

  describe "#initialize" do
    its(:implant) { should eq(implant) }
  end

  # private methods

  describe "#attribute_ids" do
    specify { expect(subject.send(:attribute_ids)).to eq([101, 102, 103, 104, 105]) }
  end
end
