# frozen_string_literal: true

class ImportMissingForDevelopment
  def import
    Rails.logger.info "Import eve races"
    Eve::UpdateRacesJob.perform_later

    Rails.logger.info "Import eve bloodlines"
    Eve::UpdateBloodlinesJob.perform_later

    Rails.logger.info "Import eve factions"
    Eve::UpdateFactionsJob.perform_later

    Rails.logger.info "Import eve ancestries"
    Eve::UpdateAncestriesJob.perform_later

    Rails.logger.info "Import character attributes from SDE"
    Sde::CharacterAttributesJob.perform_later("static/sde/fsd/characterAttributes.yaml")

    Rails.logger.info "Import icons from SDE"
    Sde::IconsJob.perform_later("static/sde/fsd/iconIDs.yaml")

    Rails.logger.info "Import agents from SDE"
    Sde::AgentsJob.perform_later("static/sde/fsd/agents.yaml")

    Rails.logger.info "Import eve alliances"
    Character.where.not(alliance_id: nil)
      .pluck(:alliance_id)
      .sort
      .uniq
      .each do |alliance_id|
      Eve::UpdateAllianceJob.perform_later(alliance_id)
    end

    Rails.logger.info "Import eve corporations"
    Character.pluck(:corporation_id).sort.uniq.each do |corporation_id|
      Eve::UpdateCorporationJob.perform_later(corporation_id)
    end

    Rails.logger.info "Import eve ships"
    Character.where.not(current_ship_type_id: nil)
      .pluck(:current_ship_type_id)
      .sort
      .uniq
      .each do |type_id|
      Eve::UpdateTypeJob.perform_later(type_id)
    end

    Rails.logger.info "Import eve systems"
    Character.where.not(current_solar_system_id: nil)
      .pluck(:current_solar_system_id)
      .sort
      .uniq
      .each do |system_id|
      Eve::UpdateSystemJob.perform_later(system_id)
    end

    Rails.logger.info "Import eve stations"
    Character.where.not(current_station_id: nil)
      .pluck(:current_station_id)
      .sort
      .uniq
      .each do |station_id|
      Eve::UpdateStationJob.perform_later(station_id)
    end

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
