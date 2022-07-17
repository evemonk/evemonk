# frozen_string_literal: true

namespace :evemonk do
  namespace :sde do
    desc "Init and update SDE"
    task update: :environment do
      Rails.logger.info "Import character attributes from SDE"
      Sde::CharacterAttributesJob.perform_later("static/sde/fsd/characterAttributes.yaml")

      Rails.logger.info "Import icons from SDE"
      Sde::IconsJob.perform_later("static/sde/fsd/iconIDs.yaml")

      # NOTE: Removed in 2021-02-12 release of SDE
      # Rails.logger.info "Import units from SDE"
      # Sde::UnitsJob.perform_later("static/sde/bsd/eveUnits.yaml")

      Rails.logger.info "Import agents from SDE"
      Sde::AgentsJob.perform_later("static/sde/fsd/agents.yaml")

      Rails.logger.info "Import agent names from SDE"
      Sde::AgentNamesJob.perform_later("static/sde/bsd/invNames.yaml")

      Rails.logger.info "Import base price for eve types from SDE"
      Sde::BasePricesJob.perform_later("static/sde/fsd/typeIDs.yaml")

      # TODO: finish
      # Rails.logger.info "Import list of blueprints from SDE"
      # Sde::BlueprintsListJob.perform_later("static/sde/fsd/blueprints.yaml")

      Rails.logger.info "Import blueprints from SDE"
      Sde::BlueprintsJob.perform_later("static/sde/fsd/blueprints.yaml")

      Rails.logger.info "Import certificates from SDE"
      Sde::CertificatesJob.perform_later("static/sde/fsd/certificates.yaml")

      Rails.logger.info "Import missing Market Groups info from SDE"
      Sde::MarketGroupsJob.perform_later("static/sde/fsd/marketGroups.yaml")

      Rails.logger.info "Import NPC Corporation Divisions from SDE"
      Sde::NpcCorporationDivisionJob.perform_later("static/sde/fsd/npcCorporationDivisions.yaml")
    end
  end

  desc "Init new evemonk installation"
  task init: :environment do
    # 6 call to esi
    Rails.logger.info "Import eve races"
    Eve::UpdateRacesJob.perform_later

    # 6 call to esi
    Rails.logger.info "Import eve bloodlines"
    Eve::UpdateBloodlinesJob.perform_later

    # 6 call to esi
    Rails.logger.info "Import eve ancestries"
    Eve::UpdateAncestriesJob.perform_later

    # 6 call to esi
    Rails.logger.info "Import eve factions"
    Eve::UpdateFactionsJob.perform_later

    # Around 300 calls to esi
    Rails.logger.info "Import eve categories"
    Eve::UpdateCategoriesJob.perform_later

    # Around 9k calls to esi
    Rails.logger.info "Import eve groups"
    Eve::UpdateGroupsJob.perform_later

    # Around 11k calls to esi
    Rails.logger.info "Import eve market groups"
    Eve::UpdateMarketGroupsJob.perform_later

    # Around 4k calls to esi
    Rails.logger.info "Import eve graphics"
    Eve::UpdateGraphicsJob.perform_later

    # Around 2500 calls to esi
    Rails.logger.info "Import eve dogma attributes"
    Eve::UpdateDogmaAttributesJob.perform_later

    # Around 235k calls to esi
    Rails.logger.info "Import eve types"
    Eve::UpdateTypesJob.perform_later

    # Around 7k calls to esi
    Rails.logger.info "Import eve constellations"
    Eve::UpdateConstellationsJob.perform_later

    # Around 650 calls to esi
    Rails.logger.info "Import eve regions"
    Eve::UpdateRegionsJob.perform_later

    # Around 50k calls to esi
    Rails.logger.info "Import new eve systems"
    Eve::UpdateSystemsJob.perform_later

    # # Around 8k calls to esi
    # Rails.logger.info "Update eve stars"
    # Eve::LocalStarsJob.perform_later
    #
    # # Around 14k calls to esi
    # Rails.logger.info "Update eve stargates"
    # Eve::LocalStargatesJob.perform_later
    #
    # # Around 5k calls to esi
    # Rails.logger.info "Update eve stations"
    # Eve::LocalStationsJob.perform_later
    #
    # # Around 68k calls to esi
    # Rails.logger.info "Update eve planets"
    # Eve::LocalPlanetsJob.perform_later
    #
    # # Around 56k calls to esi
    # Rails.logger.info "Update eve asteroid belts"
    # Eve::LocalAsteroidBeltsJob.perform_later
    #
    # # Around 342k calls to esi
    # Rails.logger.info "Update eve moons"
    # Eve::LocalMoonsJob.perform_later

    # 1 call to esi
    Rails.logger.info "Import NPC Corporations"
    Eve::NpcCorporationsJob.perform_later
  end

  desc "Update static data from new eve online release"
  task update: :environment do
    # 6 call to esi
    Rails.logger.info "Update eve races"
    Eve::UpdateRacesJob.perform_later

    # 6 call to esi
    Rails.logger.info "Update eve bloodlines"
    Eve::UpdateBloodlinesJob.perform_later

    # 6 call to esi
    Rails.logger.info "Update eve ancestries"
    Eve::UpdateAncestriesJob.perform_later

    # 6 call to esi
    Rails.logger.info "Update eve factions"
    Eve::UpdateFactionsJob.perform_later

    # 1 + new categories calls to esi
    Rails.logger.info "Import new eve categories"
    Eve::UpdateCategoriesJob.perform_later

    # Around 300 calls to esi
    Rails.logger.info "Update eve categories"
    Eve::LocalCategoriesJob.perform_later

    # 1 + new groups calls to esi
    Rails.logger.info "Import new eve groups"
    Eve::UpdateGroupsJob.perform_later

    # Around 9k calls to esi
    Rails.logger.info "Update eve groups"
    Eve::LocalGroupsJob.perform_later

    # 1 + new market groups calls to esi
    Rails.logger.info "Import new eve market groups"
    Eve::UpdateMarketGroupsJob.perform_later

    # Around 11k calls to esi
    Rails.logger.info "Update eve market groups"
    Eve::LocalMarketGroupsJob.perform_later

    # 1 + new graphics calls to esi
    Rails.logger.info "Import new eve graphics"
    Eve::UpdateGraphicsJob.perform_later

    # Around 4k calls to esi
    Rails.logger.info "Update eve graphics"
    Eve::LocalGraphicsJob.perform_later

    # TODO: dogma attributes broken???

    # 1 + new dogma attribute calls to esi
    Rails.logger.info "Import new eve dogma attributes"
    Eve::UpdateDogmaAttributesJob.perform_later

    # Around 2500 calls to esi
    Rails.logger.info "Update eve dogma attributes"
    Eve::LocalDogmaAttributesJob.perform_later

    # 1 + new types calls to esi
    Rails.logger.info "Import new eve types"
    Eve::UpdateTypesJob.perform_later

    # Around 235k calls to esi
    Rails.logger.info "Update eve types"
    Eve::LocalTypesJob.perform_later

    # 1 + new constellations calls to esi
    Rails.logger.info "Import new eve constellations"
    Eve::UpdateConstellationsJob.perform_later

    # Around 7k calls to esi
    Rails.logger.info "Update eve constellations"
    Eve::LocalConstellationsJob.perform_later

    # 1 + new regions calls to esi
    Rails.logger.info "Import new eve regions"
    Eve::UpdateRegionsJob.perform_later

    # Around 700 calls to esi
    Rails.logger.info "Update eve regions"
    Eve::LocalRegionsJob.perform_later

    # 1 + new systems
    Rails.logger.info "Import new eve systems"
    Eve::UpdateSystemsJob.perform_later

    # Around 49k calls to esi
    Rails.logger.info "Update eve systems"
    Eve::LocalSystemsJob.perform_later

    # Around 8k calls to esi
    Rails.logger.info "Update eve stars"
    Eve::LocalStarsJob.perform_later

    # Around 14k calls to esi
    Rails.logger.info "Update eve stargates"
    Eve::LocalStargatesJob.perform_later

    # Around 5k calls to esi
    Rails.logger.info "Update eve stations"
    Eve::LocalStationsJob.perform_later

    # Around 68k calls to esi
    Rails.logger.info "Update eve planets"
    Eve::LocalPlanetsJob.perform_later

    # Around 56k calls to esi
    Rails.logger.info "Update eve asteroid belts"
    Eve::LocalAsteroidBeltsJob.perform_later

    # Around 342k calls to esi
    Rails.logger.info "Update eve moons"
    Eve::LocalMoonsJob.perform_later

    # 1 + new alliances calls to esi
    Rails.logger.info "Import new eve alliances"
    Eve::UpdateAlliancesJob.perform_later

    # Around 3k calls to esi
    Rails.logger.info "Update eve alliances"
    Eve::LocalAlliancesJob.perform_later

    # Around 3k calls to esi
    Rails.logger.info "Update eve alliances corporations"
    Eve::UpdateAlliancesCorporationsJob.perform_later

    # number of new corporations calls to esi
    Rails.logger.info "Import new eve corporations"
    Eve::UpdateCorporationsJob.perform_later

    # Around 788k calls to esi
    Rails.logger.info "Update eve corporations"
    Eve::LocalCorporationsJob.perform_later

    # Around 788k calls to esi
    Rails.logger.info "Update eve corporations alliance history"
    Eve::UpdateCorporationsAllianceHistoryJob.perform_later

    # number of new characters calls to esi
    Rails.logger.info "Import new eve characters"
    Eve::UpdateCharactersJob.perform_later

    # Around 700k calls to esi
    Rails.logger.info "Update eve characters"
    Eve::LocalCharactersJob.perform_later

    # Around 700k calls to esi
    Rails.logger.info "Update eve characters corporation history"
    Eve::UpdateCharactersCorporationHistoryJob.perform_later

    # 1 call to esi
    Rails.logger.info "Update NPC Corporations"
    Eve::NpcCorporationsJob.perform_later

    Rails.logger.info "Update sitemap and ping google"
    SitemapUpdaterJob.perform_later
  end

  desc "Import missing data for development"
  task import_missing_data_for_development: :environment do
    ImportMissingForDevelopmentJob.perform_later
  end
end
