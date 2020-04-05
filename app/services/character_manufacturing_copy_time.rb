# frozen_string_literal: true

class CharacterManufacturingCopyTime
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

  def dogma_attribute_copy_speed_bonus_id
    Eve::DogmaAttribute.find_by(name: DOGMA_ATTRIBUTE_COPY_SPEED_BONUS).attribute_id
  end

  def science_copy_bonus_value
    character.science_skill&.skill&.type_dogma_attributes&.find_by(attribute_id: dogma_attribute_copy_speed_bonus_id)&.value || 0
  end

  def science_copy_bonus
    character.science_level * science_copy_bonus_value
  end

  def dogma_attribute_job_time_bonus
    Eve::DogmaAttribute.find_by(name: DOGMA_ATTRIBUTE_JOB_TIME_BONUS).attribute_id
  end

  def advanced_industry_job_time_bonus_value
    character.advanced_industry_skill&.skill&.type_dogma_attributes&.find_by(attribute_id: dogma_attribute_job_time_bonus)&.value || 0
  end

  def advanced_industry_job_time_bonus
    character.advanced_industry_level * advanced_industry_job_time_bonus_value
  end
end
