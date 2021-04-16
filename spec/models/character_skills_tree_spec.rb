# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillsTree do
  it { expect(described_class::SKILLS_CATEGORY_ID).to eq(16) }

  it { expect(described_class::PRIMARY_ATTRIBUTE_NAME).to eq("primaryAttribute") }

  it { expect(described_class::SECONDARY_ATTRIBUTE_NAME).to eq("secondaryAttribute") }

  let(:character) { instance_double(Character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end
end
