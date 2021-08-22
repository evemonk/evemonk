# frozen_string_literal: true

class ImportMissingOld
  def import
    Rails.logger.info "Import eve ships"
    Character.where.not(current_ship_type_id: nil)
      .pluck(:current_ship_type_id)
      .sort
      .uniq
      .each do |type_id|
      Eve::UpdateTypeJob.perform_later(type_id)
    end

    # belongs_to :current_solar_system,
    #            class_name: "Eve::System",
    #            primary_key: "system_id",
    #            foreign_key: "current_solar_system_id",
    #            optional: true
    #
    # belongs_to :current_station,
    #            class_name: "Eve::Station",
    #            primary_key: "station_id",
    #            foreign_key: "current_station_id",
    #            optional: true


    # has_many :loyalty_points, dependent: :destroy
    #
    # has_many :character_assets, dependent: :destroy
    #
    # has_many :character_implants, dependent: :destroy
    #
    # has_many :implants, through: :character_implants
    #
    # has_many :skillqueues, dependent: :destroy
    #
    # has_many :character_skills, dependent: :destroy
    #
    # has_many :character_corporation_histories,
    #          primary_key: "character_id",
    #          dependent: :destroy
    #
    # has_many :character_mail_labels, dependent: :destroy
    #
    # has_many :standings, dependent: :destroy
    #
    # has_many :character_killmails, dependent: :destroy
    #
    # has_many :wallet_journals, dependent: :destroy
    #
    # has_many :wallet_transactions, dependent: :destroy
    #
    # has_many :character_blueprints, dependent: :destroy
    #
    # has_many :industry_jobs, dependent: :destroy
    #
    # has_many :character_orders, dependent: :destroy
    #
    # has_many :manufacturing_jobs, dependent: :destroy
    #
    # has_many :notifications, as: :recipient, dependent: :destroy
    #
    # has_many :factions_standings, -> {
    #   joins("LEFT JOIN eve_factions ON standings.standingable_id = eve_factions.id")
    #     .where(standingable_type: "Eve::Faction")
    #     .order("eve_factions.name_en": :asc)
    #     .includes(:standingable)
    # }, class_name: "Standing"
    #
    # has_many :corporations_standings, -> {
    #   joins("LEFT JOIN eve_corporations ON standings.standingable_id = eve_corporations.id")
    #     .where(standingable_type: "Eve::Corporation")
    #     .order("eve_corporations.name": :asc)
    #     .includes(:standingable)
    # }, class_name: "Standing"
    #
    # has_many :agents_standings, -> {
    #   joins("LEFT JOIN eve_agents ON standings.standingable_id = eve_agents.id")
    #     .where(standingable_type: "Eve::Agent")
    #     .order("eve_agents.name": :asc)
    #     .includes(:standingable)
    # }, class_name: "Standing"
    #
    # scope :with_valid_tokens, -> { where(esi_token_valid: true) }


    # def perception_attribute
    #   @perception_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Perception")
    # end
    #
    # def memory_attribute
    #   @memory_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Memory")
    # end
    #
    # def willpower_attribute
    #   @willpower_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Willpower")
    # end
    #
    # def intelligence_attribute
    #   @intelligence_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Intelligence")
    # end
    #
    # def charisma_attribute
    #   @charisma_attribute ||= Eve::CharacterAttribute.find_by(name_en: "Charisma")
    # end
    #
    # def character_attributes
    #   @character_attributes ||= CharacterAttributes.new(self)
    # end
    #
    # def character_skills_levels
    #   @character_skills_levels ||= CharacterSkillsLevels.new(self)
    # end

  end
end
