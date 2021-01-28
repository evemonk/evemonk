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

  private

  def skills_category
    @skills_category ||= Eve::Category
      .published
      .find_by!(category_id: SKILLS_CATEGORY_ID)
  end

  # def total_levels_in_group(group)
  #   group.types.where(published: true).count * 5
  # end
  #
  # def skill_points_in_group(group)
  #   skill_ids = group.types.pluck(:type_id)
  #
  #   character.character_skills
  #     .where(skill_id: skill_ids)
  #     .pluck(:skillpoints_in_skill)
  #     .sum
  # end
  #
  # def skills_in_group(group)
  #   group.types.order(:name_en)
  # end
  #
  # def skill(skill)
  #   character.character_skills.where(skill_id: skill.type_id).first
  # end
end
