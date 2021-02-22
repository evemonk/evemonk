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
      .includes(:types)
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
    Eve::Certificate.where(group_id: group.group_id).count
  end

  def training_rate_in_group(_group)
    1.0
  end

  private

  def skills_category
    @skills_category ||= Eve::Category
      .published
      .find_by!(category_id: SKILLS_CATEGORY_ID)
  end

  # def skills_in_group(group)
  #   group.types.order(:name_en)
  # end
  #
  # def skill(skill)
  #   character.character_skills.where(skill_id: skill.type_id).first
  # end
end
