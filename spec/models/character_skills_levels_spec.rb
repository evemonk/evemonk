# frozen_string_literal: true

require "rails_helper"

describe CharacterSkillsLevels do
  let!(:character) { create(:character) }

  subject { described_class.new(character) }

  describe "#initialize" do
    its(:character) { should eq(character) }
  end

  describe "#science_skill" do
    let!(:character_skill) do
      create(:character_skill,
        character: character,
        skill_id: Eve::Skills::SCIENCE_ID)
    end

    specify { expect(subject.science_skill).to eq(character_skill) }
  end

  describe "#science_level" do
    context "when character does not have science skill" do
      specify { expect(subject.science_level).to eq(0) }
    end

    context "when character have science skill" do
      let!(:character_skill) do
        create(:character_skill,
          character: character,
          skill_id: Eve::Skills::SCIENCE_ID,
          active_skill_level: 5)
      end

      specify { expect(subject.science_level).to eq(5) }
    end
  end

  describe "#advanced_industry_skill" do
    let!(:character_skill) do
      create(:character_skill,
        character: character,
        skill_id: Eve::Skills::ADVANCED_INDUSTRY_ID)
    end

    specify { expect(subject.advanced_industry_skill).to eq(character_skill) }
  end

  describe "#advanced_industry_level" do
    context "when character does not have advanced industry skill" do
      specify { expect(subject.advanced_industry_level).to eq(0) }
    end

    context "when character have advanced industry skill" do
      let!(:character_skill) do
        create(:character_skill,
          character: character,
          skill_id: Eve::Skills::ADVANCED_INDUSTRY_ID,
          active_skill_level: 5)
      end

      specify { expect(subject.advanced_industry_level).to eq(5) }
    end
  end
end
