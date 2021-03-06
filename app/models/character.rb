# frozen_string_literal: true

class Character < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include ImageProxy

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
    class_name: "Eve::Ship",
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

  has_many :etags, dependent: :destroy

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

  has_many :character_killmails, dependent: :destroy

  has_many :wallet_journals, dependent: :destroy

  has_many :wallet_transactions, dependent: :destroy

  has_many :character_blueprints, dependent: :destroy

  has_many :industry_jobs, dependent: :destroy

  has_many :character_orders, dependent: :destroy

  has_many :manufacturing_jobs, dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy

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

  scope :with_valid_tokens, -> { where(esi_token_valid: true) }

  delegate :perception_without_bonuses, :perception_bonus,
    :memory_without_bonuses, :memory_bonus,
    :willpower_without_bonuses, :willpower_bonus,
    :intelligence_without_bonuses, :intelligence_bonus,
    :charisma_without_bonuses, :charisma_bonus, to: :character_attributes

  delegate :science_skill, :science_level, :advanced_industry_skill,
    :advanced_industry_level, to: :character_skills_levels

  def perception_attribute
    @perception_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Perception")
  end

  def memory_attribute
    @memory_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Memory")
  end

  def willpower_attribute
    @willpower_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Willpower")
  end

  def intelligence_attribute
    @intelligence_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Intelligence")
  end

  def charisma_attribute
    @charisma_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Charisma")
  end

  def character_attributes
    @character_attributes ||= CharacterAttributes.new(self)
  end

  def character_skills_levels
    @character_skills_levels ||= CharacterSkillsLevels.new(self)
  end

  def token_expired?
    token_expires_at <= Time.zone.now
  end

  # TODO: write
  # def alpha?
  #   true
  # end

  # TODO: write
  # def omega?
  #   true
  # end

  def icon_tiny
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=32"
  end

  def icon_small
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=64"
  end

  def icon_medium
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=128"
  end

  def icon_large
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=256"
  end

  def icon_huge
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=512"
  end

  def icon_gigantic
    "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=1024"
  end

  def wallet_formatted
    number_with_delimiter(wallet.to_i, delimiter: " ")
  end

  def total_sp_formatted
    number_with_delimiter(total_sp, delimiter: " ")
  end

  def unallocated_sp_formatted
    number_with_delimiter(unallocated_sp, delimiter: " ")
  end

  def full_sp_formatted
    number_with_delimiter(total_sp.to_i + unallocated_sp.to_i, delimiter: " ")
  end

  def birthday_formatted
    birthday&.strftime("%Y.%m.%d")
  end

  # def last_clone_jump_date_formatted
  #   object.last_clone_jump_date&.strftime("%Y.%m.%d")
  # end

  # add_column :characters, :last_clone_jump_date, :datetime
  # add_column :characters, :last_station_change_date, :datetime

  # def neural_remap_available
  #   if object.accrued_remap_cooldown_date&.past?
  #     "Now"
  #   else
  #     object.accrued_remap_cooldown_date&.strftime("%b %d, %Y")
  #   end
  # end

  def sanitized_description
    Rails::Html::FullSanitizer.new.sanitize(description)
  end

  def rounded_security_status
    security_status&.round(1)
  end
end
