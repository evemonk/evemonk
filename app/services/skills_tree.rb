class SkillsTree
  SKILLS_CATEGORY_ID = 16

  attr_reader :character

  def initialize(character)
    @character = character
  end

  def groups
    @groups ||= Eve::Category.find_by!(category_id: SKILLS_CATEGORY_ID)
                             .groups
                             .where(published: true)
                             .order(:name_en)
                             .decorate
  end

  def total_levels_in_group(group)
    group.types.where(published: true).count * 5
  end

  def levels_trained_in_group(group)
    skill_ids = group.types.pluck(:type_id)

    character.character_skills.where(skill_id: skill_ids).pluck(:trained_skill_level).sum
  end
end
