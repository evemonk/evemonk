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

    character_skills

    self
  end

  def skills_groups
    @skills_groups ||= Eve::Group.published.where(category_id: skill_category.category_id).order(:name_en).to_a
  end

  def skills_count_in_group(group_id)
    skills_types.select { |type| type.group_id == group_id }.size
  end

  def levels_trained_in_group(group_id)
    skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)

    character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.map(&:trained_skill_level).sum
  end

  private

  def skill_category
    @skill_category ||= Eve::Category.published.find_by!(category_id: SKILLS_CATEGORY_ID)
  end

  def skills_types
    @skills_types ||= Eve::Type.published.where(group_id: skills_groups.map(&:group_id)).to_a
  end

  def character_skills
    @character_skills ||= character.character_skills.to_a
  end
end
