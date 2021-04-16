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

  describe "#preload" do
    before { expect(subject).to receive(:skill_category) }

    before { expect(subject).to receive(:skills_groups) }

    before { expect(subject).to receive(:skills_types) }

    before { expect(subject).to receive(:character_skills) }

    before { expect(subject).to receive(:character_skillqueues) }

    before { expect(subject).to receive(:certificates) }

    before { expect(subject).to receive(:dogma_attributes) }

    before { expect(subject).to receive(:type_dogma_attributes) }

    before { expect(subject).to receive(:more_dogma_attributes) }

    specify { expect(subject.preload).to eq(subject) }
  end
end
