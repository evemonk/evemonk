# frozen_string_literal: true

namespace :evemonk do
  desc "Init new evemonk installation"
  task init: :environment do
    # 7 call to esi
    Rails.logger.info "Import eve races"
    Eve::UpdateRacesJob.new.perform

    # 7 call to esi
    Rails.logger.info "Import eve bloodlines"
    Eve::UpdateBloodlinesJob.perform_later

    # 7 call to esi
    Rails.logger.info "Import eve ancestries"
    Eve::UpdateAncestriesJob.perform_later

    # 7 call to esi
    Rails.logger.info "Import eve factions"
    Eve::UpdateFactionsJob.perform_later

    Rails.logger.info "Import character attributes from SDE"
    Sde::CharacterAttributesImporter.new("static/sde/bsd/chrAttributes.yaml").import

    Rails.logger.info "Import icons from SDE"
    Sde::IconsImporter.new("static/sde/fsd/iconIDs.yaml").import

    Rails.logger.info "Import units from SDE"
    Sde::UnitsImporter.new("static/sde/bsd/eveUnits.yaml").import

    # Around 300 calls to esi
    Rails.logger.info "Import eve categories"
    Eve::UpdateCategoriesJob.perform_later

    # Around 10k calls to esi
    Rails.logger.info "Import eve groups"
    Eve::UpdateGroupsJob.perform_later

    # Around 13k calls to esi
    Rails.logger.info "Import eve market groups"
    Eve::UpdateMarketGroupsJob.perform_later

    # Around 4k calls to esi
    Rails.logger.info "Import eve graphics"
    Eve::UpdateGraphicsJob.perform_later

    # Around 2500 calls to esi
    Rails.logger.info "Import eve dogma attributes"
    Eve::UpdateDogmaAttributesJob.perform_later

    # Around 250k calls to esi
    Rails.logger.info "Import eve types"
    Eve::UpdateTypesJob.perform_later

    # Around 10k calls to esi
    Rails.logger.info "Import eve constellations"
    Eve::UpdateConstellationsJob.perform_later

    # Around 700 calls to esi
    Rails.logger.info "Import eve regions"
    Eve::UpdateRegionsJob.perform_later

    # Around 60k calls to esi
    Rails.logger.info "Import new eve systems"
    Eve::UpdateSystemsJob.perform_later
  end

  desc "Update static data from new eve online release"
  task update: :environment do
    # 7 call to esi
    Rails.logger.info "Update eve races"
    Eve::UpdateRacesJob.perform_later

    # 7 call to esi
    Rails.logger.info "Update eve bloodlines"
    Eve::UpdateBloodlinesJob.perform_later

    # 7 call to esi
    Rails.logger.info "Update eve ancestries"
    Eve::UpdateAncestriesJob.perform_later

    # 7 call to esi
    Rails.logger.info "Update eve factions"
    Eve::UpdateFactionsJob.perform_later

    # TODO: add SDE importers

    # 1 + new categories calls to esi
    Rails.logger.info "Import new eve categories"
    Eve::UpdateCategoriesJob.perform_later

    # Around 300 calls to esi
    Rails.logger.info "Update eve categories"
    Eve::LocalCategoriesJob.perform_later

    # 1 + new groups calls to esi
    Rails.logger.info "Import new eve groups"
    Eve::UpdateGroupsJob.perform_later

    # Around 10k calls to esi
    Rails.logger.info "Update eve groups"
    Eve::LocalGroupsJob.perform_later

    # 1 + new market groups calls to esi
    Rails.logger.info "Import new eve market groups"
    Eve::UpdateMarketGroupsJob.perform_later

    # Around 13k calls to esi
    Rails.logger.info "Update eve market groups"
    Eve::LocalMarketGroupsJob.perform_later

    # 1 + new graphics calls to esi
    Rails.logger.info "Import new eve graphics"
    Eve::UpdateGraphicsJob.perform_later

    # Around 4k calls to esi
    Rails.logger.info "Update eve graphics"
    Eve::LocalGraphicsJob.perform_later

    # 1 + new dogma attribute calls to esi
    Rails.logger.info "Import new eve dogma attributes"
    Eve::UpdateDogmaAttributesJob.perform_later

    # Around 2500 calls to esi
    Rails.logger.info "Update eve dogma attributes"
    Eve::LocalDogmaAttributesJob.perform_later

    # 1 + new types calls to esi
    Rails.logger.info "Import new eve types"
    Eve::UpdateTypesJob.perform_later

    # Around 250k calls to esi
    Rails.logger.info "Update eve types"
    Eve::LocalTypesJob.perform_later

    # 1 + new constellations calls to esi
    Rails.logger.info "Import new eve constellations"
    Eve::UpdateConstellationsJob.perform_later

    # Around 10k calls to esi
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

    # Around 60k calls to esi
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

    # alliance.rb
    # alliance_corporation.rb
    # character.rb
    # character_corporation_history.rb
    # corporation.rb
    # corporation_alliance_history.rb

    Rails.logger.info "Update sitemap and ping google"
    SitemapUpdaterJob.perform_later
  end
end
