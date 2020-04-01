# frozen_string_literal: true

class CharacterManufacturingCopyTime
  SCIENCE_SKILL_ID = 3402
  ADVANCED_INDUSTRY_SKILL_ID = 3388
  DOGMA_ATTRIBUTE_COPY_SPEED_BONUS = "copySpeedBonus"
  DOGMA_ATTRIBUTE_JOB_TIME_BONUS = "advancedIndustrySkillIndustryJobTimeBonus"

  attr_reader :character, :seconds

  def initialize(character, seconds)
    @character = character
    @seconds = seconds
  end

  def manufacturing_copy_time
    (seconds * time_modifier)
  end

  def time_modifier
    science_copy_bonus_time_modifier * advanced_industry_job_time_bonus_time_modifier
  end

  def science_copy_bonus_time_modifier
    (100.0 + science_copy_bonus) / 100.0
  end

  def advanced_industry_job_time_bonus_time_modifier
    (100.0 + advanced_industry_job_time_bonus) / 100.0
  end

  private

  # Science
  def science_skill
    character.character_skills.find_by(skill_id: SCIENCE_SKILL_ID)
  end

  def science_level
    # https://www.reddit.com/r/evetech/comments/bndjwi/difference_between_active_skill_level_and_trained/
    science_skill&.active_skill_level || 0
  end

  def dogma_attribute_copy_speed_bonus_id
    Eve::DogmaAttribute.find_by(name: DOGMA_ATTRIBUTE_COPY_SPEED_BONUS).attribute_id
  end

  def science_copy_bonus_value
    science_skill&.skill&.type_dogma_attributes&.find_by(attribute_id: dogma_attribute_copy_speed_bonus_id)&.value || 0
  end

  def science_copy_bonus
    science_level * science_copy_bonus_value
  end

  # Advanced Industry
  def advanced_industry_skill
    character.character_skills.find_by(skill_id: ADVANCED_INDUSTRY_SKILL_ID)
  end

  def advanced_industry_level
    # https://www.reddit.com/r/evetech/comments/bndjwi/difference_between_active_skill_level_and_trained/
    advanced_industry_skill&.active_skill_level || 0
  end

  def dogma_attribute_job_time_bonus
    Eve::DogmaAttribute.find_by(name: DOGMA_ATTRIBUTE_JOB_TIME_BONUS).attribute_id
  end

  def advanced_industry_job_time_bonus_value
    advanced_industry_skill&.skill&.type_dogma_attributes&.find_by(attribute_id: dogma_attribute_job_time_bonus)&.value || 0
  end

  def advanced_industry_job_time_bonus
    advanced_industry_level * advanced_industry_job_time_bonus_value
  end
end
