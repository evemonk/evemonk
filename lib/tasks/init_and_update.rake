# frozen_string_literal: true

namespace :evemonk do
  task init: :environment do
    # 7 call to esi
    Rails.logger.info "Import eve races"
    Eve::UpdateRacesJob.new.perform

    Eve::UpdateFactionsJob.new.perform
    Eve::UpdateBloodlinesJob.new.perform
    Eve::UpdateAncestriesJob.new.perform

    Sde::CharacterAttributesImporter.new("static/sde/bsd/chrAttributes.yaml").import
    Sde::IconsImporter.new("static/sde/fsd/iconIDs.yaml").import
  end

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

    # 1 + new categories calls to esi
    Rails.logger.info "Import new eve categories"
    Eve::UpdateCategoriesJob.perform_later

    # 1 + new groups calls to esi
    Rails.logger.info "Import new eve groups"
    Eve::UpdateGroupsJob.perform_later

    # 1 + new market groups calls to esi
    Rails.logger.info "Import new eve market groups"
    Eve::UpdateMarketGroupsJob.perform_later

    # 1 + new graphics calls to esi
    Rails.logger.info "Import new eve graphics"
    Eve::UpdateGraphicsJob.perform_later

    # 1 + new dogma attribute calls to esi
    Rails.logger.info "Import new eve dogma attributes"
    Eve::UpdateDogmaAttributesJob.perform_later

    # 1 + new types calls to esi
    Rails.logger.info "Import new eve types"
    Eve::UpdateTypesJob.perform_later

    # 1 + new constellations calls to esi
    Rails.logger.info "Import new eve constellations"
    Eve::UpdateConstellationsJob.perform_later

    # 1 + new regions calls to esi
    Rails.logger.info "Import new eve regions"
    Eve::UpdateRegionsJob.perform_later

    # 1 + new alliances calls to esi
    Rails.logger.info "Import new eve alliances"
    Eve::UpdateAlliancesJob.perform_later

    # number of new corporations calls to esi
    Rails.logger.info "Import new eve corporations"
    Eve::UpdateCorporationsJob.perform_later

    Rails.logger.info "Import new eve characters"
    Eve::UpdateCharactersJob.perform_later

    Rails.logger.info "Update sitemap and ping google"
    SitemapUpdaterJob.perform_later

  end
end
