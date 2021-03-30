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

    character_skillqueues

    certificates

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

  def total_levels_in_group(group_id)
    skills_types.select { |type| type.group_id == group_id }.size * 5
  end

  def levels_in_training_queue(group_id)
    skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)

    character_skillqueues.select { |skillqueue| skill_ids.include?(skillqueue.skill_id) }.size
  end

  def current_skill_points_in_group(group_id)
    skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)

    character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.map(&:skillpoints_in_skill).sum
  end

  def total_skill_points_in_group(group_id)
    0
  end

  def certificates_claimed_in_group(group_id)
    0
  end

  def total_certificates_in_group(group_id)
    certificates.select { |certificate| certificate.group_id == group_id }.size
  end

  def skills_in_group(group_id)
    skills_types.select { |type| type.group_id == group_id }.sort_by(&:name_en)
  end

  private

  def skill_category
    @skill_category ||= Eve::Category.published.find_by!(category_id: SKILLS_CATEGORY_ID)
  end

  def skills_types
    @skills_types ||= Eve::Type.published.where(group_id: skills_groups.map(&:group_id)).to_a
  end

  def certificates
    @certificates ||= Eve::Certificate.all.to_a
  end

  def character_skills
    @character_skills ||= character.character_skills.to_a
  end

  def character_skillqueues
    @character_skillqueues ||= character.skillqueues.order(:queue_position).where("skillqueues.finish_date > :now", now: Time.zone.now).to_a
  end
end
