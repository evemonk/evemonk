# frozen_string_literal: true

require_relative "config/environment"

scheduler = Rufus::Scheduler.new

scheduler.every "1h" do
  Rails.logger.info "Update characters"
  UpdateCharactersJob.perform_later
end

scheduler.every "every day at 2 pm" do
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

  # categories/market groups/groups

  #category.rb -- 43
  #dogma_attribute.rb -- 2486
  #graphic.rb -- 3848
  #group.rb -- 1401
  #market_group.rb -- 1873
  #type.rb -- 36776

  Rails.logger.info "Import new eve alliances"
  Eve::UpdateAlliancesJob.perform_later

  Rails.logger.info "Update sitemap and ping google"
  SitemapUpdaterJob.perform_later
end

scheduler.every "every monday at 2 pm" do
  # Around 3k calls to esi
  Rails.logger.info "Update eve alliances"
  Eve::LocalAlliancesJob.perform_later

  # Around 3k calls to esi
  Rails.logger.info "Update eve alliances corporations"
  Eve::UpdateAlliancesCorporationsJob.perform_later
end

scheduler.every "every tuesday at 2 pm" do
  # Around 700k calls to esi
  Rails.logger.info "Update eve corporations"
  Eve::LocalCorporationsJob.perform_later
end

scheduler.every "every wednesday at 2 pm" do
  # Around 700k calls to esi
  Rails.logger.info "Update eve corporations alliance history"
  Eve::UpdateCorporationsAllianceHistoryJob.perform_later
end

scheduler.every "every thursday at 2 pm" do
  # Around 700k calls to esi
  Rails.logger.info "Update eve characters"
  Eve::LocalCharactersJob.perform_later
end

scheduler.every "every friday at 2 pm" do
  # Around 700k calls to esi
  Rails.logger.info "Update eve characters corporation history"
  Eve::UpdateCharactersCorporationHistoryJob.perform_later
end

scheduler.every "every saturday at 2 pm" do

end

scheduler.every "every sunday at 2 pm" do

end

####

scheduler.every "every sunday at 2pm" do
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
  Rails.logger.info "Update eve dogma attributes"
  Eve::LocalDogmaAttributesJob.perform_later
end

scheduler.every "1d" do
  Rails.logger.info "Import new eve characters"
  Eve::UpdateCharactersJob.perform_later
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
