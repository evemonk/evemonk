# frozen_string_literal: true

class CharacterSkillsTree
  SKILLS_CATEGORY_ID = 16

  attr_reader :character

  def initialize(character)
    @character = character
  end

  def preload
    skill_category

    skills_groups

    skills_types

    self
  end

  def skills_groups
    @skills_groups ||= Eve::Group.published.where(category_id: skill_category.category_id).order(:name_en).to_a
  end

  def skills_count_in_group(group_id)
    skills_types.select { |type| type.group_id == group_id }.size
  end

  private

  def skill_category
    @skill_category ||= Eve::Category.published.find_by!(category_id: SKILLS_CATEGORY_ID)
  end

  def skills_types
    @skills_types ||= Eve::Type.published.where(group_id: skills_groups.map(&:group_id)).to_a
  end
end
