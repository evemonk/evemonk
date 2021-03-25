# frozen_string_literal: true

class SkillsTree
  SKILLS_CATEGORY_ID = 16

  attr_reader :character

  def initialize(character)
    @character = character
  end

  def groups
    @groups ||= skills_category
      .groups
      .published
      .includes(types: {type_dogma_attributes: :dogma_attribute})
      .where(dogma_attribute: {published: true})
      .where(types: {published: true})
      .order(:name_en)
  end

  def skills_count_in_group(group)
    group.types.published.count
  end

  def levels_trained_in_group(group)
    skill_ids = group.types.published.pluck(:type_id)

    character.character_skills
      .where(skill_id: skill_ids)
      .pluck(:trained_skill_level)
      .sum
  end

  def total_levels_in_group(group)
    group.types.published.count * 5
  end

  def levels_in_training_queue(group)
    skill_ids = group.types.published.pluck(:type_id)

    character.skillqueues
      .order(:queue_position)
      .where("skillqueues.finish_date > :now", now: Time.zone.now)
      .where(skill_id: skill_ids)
      .count
  end

  def current_skill_points_in_group(group)
    skill_ids = group.types.published.pluck(:type_id)

    character.character_skills
      .where(skill_id: skill_ids)
      .pluck(:skillpoints_in_skill)
      .sum
  end

  def total_skill_points_in_group(_group)
    0
  end

  def certificates_claimed_in_group(_group)
    0
  end

  def total_certificates_in_group(group)
    group.certificates.count
  end

  def primary_attribute_per_group(group)
    group.types.published.order(:name_en).first.primary_attribute
  end

  def secondary_attribute_per_group(group)
    group.types.published.order(:name_en).first.secondary_attribute
  end

  def training_rate_in_group(group)
    primary = character.send(:"#{primary_attribute_per_group(group).name}")
    secondary = character.send(:"#{secondary_attribute_per_group(group).name}")

    rate = EveOnline::Formulas::TrainingRate.new(primary, secondary).rate

    format("%0.2f", rate)
  end

  def skills_in_group(group)
    group.types.published.order(:name_en)
  end

  # def training_rate_for_skill(skill)
  #   primary = character.send(:"#{primary_attribute_per_group(group).name}")
  #   secondary = character.send(:"#{secondary_attribute_per_group(group).name}")
  #
  #   rate = EveOnline::Formulas::TrainingRate.new(primary, secondary).rate
  #
  #   format("%0.2f", rate)
  # end

  private

  def skills_category
    @skills_category ||= Eve::Category
      .published
      .find_by!(category_id: SKILLS_CATEGORY_ID)
  end

  # def training_time_for_skill(skill, level)
  # end

  # def total_training_time_for_skill(skill, level)
  # end

  # def skill(skill)
  #   character.character_skills.where(skill_id: skill.type_id).first
  # end
end
