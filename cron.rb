# frozen_string_literal: true

require_relative "config/environment"

scheduler = Rufus::Scheduler.new

scheduler.every "1m" do
  Rails.logger.info "Update server status"
  Eve::ServerStatusJob.perform_later
end

scheduler.every "5m" do
  Rails.logger.info "Collect postgresql query stats"
  Pghero::CaptureQueryStatsJob.perform_later
end

# scheduler.every "1h" do
#   Rails.logger.info "Update characters"
#   UpdateCharactersJob.perform_later
# end

scheduler.at "every day at 2 pm" do
  Rails.logger.info "Collection postgresql space stats"
  Pghero::CaptureSpaceStatsJob.perform_later

  ## 1 + new graphics calls to esi
  # Rails.logger.info "Import new eve graphics"
  # Eve::UpdateGraphicsJob.perform_later
  #
  ## 1 + new dogma attribute calls to esi
  # Rails.logger.info "Import new eve dogma attributes"
  # Eve::UpdateDogmaAttributesJob.perform_later
  #
  ## 1 + new types calls to esi
  # Rails.logger.info "Import new eve types"
  # Eve::UpdateTypesJob.perform_later
  #
  ## 1 + new constellations calls to esi
  # Rails.logger.info "Import new eve constellations"
  # Eve::UpdateConstellationsJob.perform_later
  #
  ## 1 + new regions calls to esi
  # Rails.logger.info "Import new eve regions"
  # Eve::UpdateRegionsJob.perform_later
  #
  ## 1 + new alliances calls to esi
  # Rails.logger.info "Import new eve alliances"
  # Eve::UpdateAlliancesJob.perform_later
  #
  ## number of new corporations calls to esi
  # Rails.logger.info "Import new eve corporations"
  # Eve::UpdateCorporationsJob.perform_later
  #
  # Rails.logger.info "Import new eve characters"
  # Eve::UpdateCharactersJob.perform_later

  Rails.logger.info "Update sitemap and ping google"
  SitemapUpdaterJob.perform_later
end

# scheduler.at "every monday at 2 pm" do
#  # Around 3k calls to esi
#  Rails.logger.info "Update eve alliances"
#  Eve::LocalAlliancesJob.perform_later
#
#  # Around 3k calls to esi
#  Rails.logger.info "Update eve alliances corporations"
#  Eve::UpdateAlliancesCorporationsJob.perform_later
# end
#
# scheduler.at "every tuesday at 2 pm" do
#  # Around 700k calls to esi
#  Rails.logger.info "Update eve corporations"
#  Eve::LocalCorporationsJob.perform_later
# end
#
# scheduler.at "every wednesday at 2 pm" do
#  # Around 700k calls to esi
#  Rails.logger.info "Update eve corporations alliance history"
#  Eve::UpdateCorporationsAllianceHistoryJob.perform_later
# end
#
# scheduler.at "every thursday at 2 pm" do
#  # Around 700k calls to esi
#  Rails.logger.info "Update eve characters"
#  Eve::LocalCharactersJob.perform_later
# end
#
# scheduler.at "every friday at 2 pm" do
#  # Around 700k calls to esi
#  Rails.logger.info "Update eve characters corporation history"
#  Eve::UpdateCharactersCorporationHistoryJob.perform_later
# end

scheduler.join
