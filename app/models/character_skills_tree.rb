# frozen_string_literal: true

class CharacterSkillsTree
  PRIMARY_ATTRIBUTE_NAME = "primaryAttribute"
  SECONDARY_ATTRIBUTE_NAME = "secondaryAttribute"

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

    dogma_attributes

    type_dogma_attributes

    more_dogma_attributes

    self
  end

  def skills_groups
    @skills_groups ||= Eve::Group.published.where(category_id: skill_category.category_id).order(:name_en).to_a
  end

  def skills_count_in_group(group_id)
    skills_types.count { |type| type.group_id == group_id }
  end

  def levels_trained_in_group(group_id)
    skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)

    character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.sum(&:trained_skill_level)
  end

  def total_levels_in_group(group_id)
    skills_types.count { |type| type.group_id == group_id } * 5
  end

  def levels_in_training_queue(group_id)
    skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)

    character_skillqueues.count { |skillqueue| skill_ids.include?(skillqueue.skill_id) }
  end

  def current_skill_points_in_group(group_id)
    skill_ids = skills_types.select { |type| type.group_id == group_id }.map(&:type_id)

    character_skills.select { |character_skill| skill_ids.include?(character_skill.skill_id) }.sum(&:skillpoints_in_skill)
  end

  def total_skill_points_in_group(_)
    0
  end

  def certificates_claimed_in_group(_)
    0
  end

  def total_certificates_in_group(group_id)
    certificates.count { |certificate| certificate.group_id == group_id }
  end

  def skills_in_group(group_id)
    skills_types.select { |type| type.group_id == group_id }.sort_by(&:name_en)
  end

  def training_rate_for_skill(skill_id)
    primary_dogma_attribute = dogma_attributes.find { |dogma_attribute| dogma_attribute.name == PRIMARY_ATTRIBUTE_NAME }
    primary_attribute_id = type_dogma_attributes.find { |tda| tda.type_id == skill_id && tda.attribute_id == primary_dogma_attribute.attribute_id }.value.to_i
    primary_attribute = more_dogma_attributes.find { |dogma_attribute| dogma_attribute.attribute_id == primary_attribute_id }

    secondary_dogma_attribute = dogma_attributes.find { |dogma_attribute| dogma_attribute.name == SECONDARY_ATTRIBUTE_NAME }
    secondary_attribute_id = type_dogma_attributes.find { |tda| tda.type_id == skill_id && tda.attribute_id == secondary_dogma_attribute.attribute_id }.value.to_i
    secondary_attribute = more_dogma_attributes.find { |dogma_attribute| dogma_attribute.attribute_id == secondary_attribute_id }

    primary = character.send(:"#{primary_attribute.name}")
    secondary = character.send(:"#{secondary_attribute.name}")

    rate = EveOnline::Formulas::TrainingRate.new(primary, secondary).rate

    format("%0.2f", rate)
  end

  private

  def skill_category
    @skill_category ||= Eve::Category.published.find_by!(category_id: Eve::Categories::SKILLS_ID)
  end

  def skills_types
    @skills_types ||= Eve::Type.published.where(group_id: skills_groups.map(&:group_id).sort.uniq).to_a
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

  def dogma_attributes
    @dogma_attributes ||= Eve::DogmaAttribute.published.where(name: [PRIMARY_ATTRIBUTE_NAME, SECONDARY_ATTRIBUTE_NAME]).to_a
  end

  def type_dogma_attributes
    @type_dogma_attributes ||= Eve::TypeDogmaAttribute.where(attribute_id: dogma_attributes.map(&:attribute_id).sort.uniq).to_a
  end

  def more_dogma_attributes
    @more_dogma_attributes ||= Eve::DogmaAttribute.published.where(attribute_id: type_dogma_attributes.map(&:value).map(&:to_i).sort.uniq).to_a
  end
end
