# frozen_string_literal: true

class Character < ApplicationRecord
  has_paper_trail

  belongs_to :user

  belongs_to :race,
    class_name: "Eve::Race",
    primary_key: "race_id",
    optional: true

  belongs_to :bloodline,
    class_name: "Eve::Bloodline",
    primary_key: "bloodline_id",
    optional: true

  belongs_to :faction,
    class_name: "Eve::Faction",
    primary_key: "faction_id",
    optional: true

  belongs_to :ancestry,
    class_name: "Eve::Ancestry",
    primary_key: "ancestry_id",
    optional: true

  belongs_to :alliance,
    class_name: "Eve::Alliance",
    primary_key: "alliance_id",
    optional: true

  belongs_to :corporation,
    class_name: "Eve::Corporation",
    primary_key: "corporation_id",
    optional: true

  belongs_to :current_ship_type,
    class_name: "Eve::Type",
    primary_key: "type_id",
    foreign_key: "current_ship_type_id",
    optional: true

  belongs_to :current_solar_system,
    class_name: "Eve::System",
    primary_key: "system_id",
    foreign_key: "current_solar_system_id",
    optional: true

  belongs_to :current_station,
    class_name: "Eve::Station",
    primary_key: "station_id",
    foreign_key: "current_station_id",
    optional: true

  # belongs_to :current_structure,
  #  class_name: "Eve::Structure",
  #  primary_key: "structure_id",
  #  foreign_key: "current_structure_id",
  #  optional: true

  has_many :loyalty_points, dependent: :destroy

  has_many :character_assets, dependent: :destroy

  has_many :character_implants, dependent: :destroy

  has_many :implants, through: :character_implants

  has_many :skillqueues, dependent: :destroy

  has_many :character_skills, dependent: :destroy

  has_many :character_corporation_histories,
    primary_key: "character_id",
    dependent: :destroy

  has_many :character_mail_labels, dependent: :destroy

  has_many :standings, dependent: :destroy

  has_many :factions_standings, -> {
    joins("LEFT JOIN eve_factions ON standings.standingable_id = eve_factions.id")
      .where(standingable_type: "Eve::Faction")
      .order("eve_factions.name_en": :asc)
      .includes(:standingable)
  }, class_name: "Standing"

  has_many :corporations_standings, -> {
    joins("LEFT JOIN eve_corporations ON standings.standingable_id = eve_corporations.id")
      .where(standingable_type: "Eve::Corporation")
      .order("eve_corporations.name": :asc)
      .includes(:standingable)
  }, class_name: "Standing"

  has_many :agents_standings, -> {
    joins("LEFT JOIN eve_agents ON standings.standingable_id = eve_agents.id")
      .where(standingable_type: "Eve::Agent")
      .order("eve_agents.name": :asc)
      .includes(:standingable)
  }, class_name: "Standing"

  def perception_attribute
    @perception_attribute ||= Eve::CharacterAttribute.find_by(attribute_name: "Perception").decorate
  end

  def memory_attribute
    @memory_attribute ||= Eve::CharacterAttribute.find_by(attribute_name: "Memory").decorate
  end

  def willpower_attribute
    @willpower_attribute ||= Eve::CharacterAttribute.find_by(attribute_name: "Willpower").decorate
  end

  def intelligence_attribute
    @intelligence_attribute ||= Eve::CharacterAttribute.find_by(attribute_name: "Intelligence").decorate
  end

  def charisma_attribute
    @charisma_attribute ||= Eve::CharacterAttribute.find_by(attribute_name: "Charisma").decorate
  end

  def skills_tree
    @skills_tree ||= SkillsTree.new(self)
  end

  def character_attributes
    @character_attributes ||= CharacterAttributes.new(self)
  end

  def token_expired?
    token_expires_at <= Time.zone.now
  end
end
