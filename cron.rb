# frozen_string_literal: true

require_relative "config/environment"

scheduler = Rufus::Scheduler.new

scheduler.every "1h" do
  Rails.logger.info "Update characters"
  UpdateCharactersJob.perform_later
end

scheduler.every "day at 2pm" do
  Rails.logger.info "Update eve races"
  Eve::UpdateRacesJob.perform_later

  Rails.logger.info "Update eve bloodlines"
  Eve::UpdateBloodlinesJob.perform_later

  Rails.logger.info "Update eve ancestries"
  Eve::UpdateAncestriesJob.perform_later

  Rails.logger.info "Update eve factions"
  Eve::UpdateFactionsJob.perform_later

  Rails.logger.info "Import new eve categories"
  Eve::UpdateCategoriesJob.perform_later

  # categories/market groups/groups

  Rails.logger.info "Import new eve alliances"
  Eve::UpdateAlliancesJob.perform_later

  Rails.logger.info "Update eve alliances"
  Eve::LocalAlliancesJob.perform_later

  Rails.logger.info "Update sitemap and ping google"
  SitemapUpdaterJob.perform_later
end

# 43
scheduler.every "7d" do
  Rails.logger.info "Update eve categories"
  Eve::LocalCategoriesJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve groups"
  Eve::UpdateGroupsJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve graphics"
  Eve::UpdateGraphicsJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve market groups"
  Eve::UpdateMarketGroupsJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve corporations"
  Eve::LocalCorporationsJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve characters"
  Eve::LocalCharactersJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve dogma attributes"
  Eve::LocalDogmaAttributesJob.perform_later
end

scheduler.every "1d" do
  Rails.logger.info "Import new eve characters"
  Eve::UpdateCharactersJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve characters corporation history"
  Eve::UpdateCharactersCorporationHistoryJob.perform_later
end

scheduler.every "1d" do
  Rails.logger.info "Import new eve corporations"
  Eve::UpdateCorporationsJob.perform_later
end

scheduler.every "1d" do
  Rails.logger.info "Import new eve dogma attributes"
  Eve::UpdateDogmaAttributesJob.perform_later
end

scheduler.join
