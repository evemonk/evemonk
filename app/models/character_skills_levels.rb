# frozen_string_literal: true

class CharacterSkillsLevels
  SCIENCE_SKILL_ID = 3402
  ADVANCED_INDUSTRY_SKILL_ID = 3388

  attr_reader :character

  def initialize(character)
    @character = character
  end

  # Science
  def science_skill
    character.character_skills.find_by(skill_id: SCIENCE_SKILL_ID)
  end

  def science_level
    # https://www.reddit.com/r/evetech/comments/bndjwi/difference_between_active_skill_level_and_trained/
    science_skill&.active_skill_level || 0
  end

  # Advanced Industry
  def advanced_industry_skill
    character.character_skills.find_by(skill_id: ADVANCED_INDUSTRY_SKILL_ID)
  end

  def advanced_industry_level
    # https://www.reddit.com/r/evetech/comments/bndjwi/difference_between_active_skill_level_and_trained/
    advanced_industry_skill&.active_skill_level || 0
  end
end
