# frozen_string_literal: true

require_relative "config/environment"

scheduler = Rufus::Scheduler.new

scheduler.every "1h" do
  Rails.logger.info "Update characters"
  UpdateCharactersJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve races"
  Eve::UpdateRacesJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve bloodlines"
  Eve::UpdateBloodlinesJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve ancestries"
  Eve::UpdateAncestriesJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve factions"
  Eve::UpdateFactionsJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve categories"
  Eve::UpdateCategoriesJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve groups"
  Eve::UpdateGroupsJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve market groups"
  Eve::UpdateMarketGroupsJob.perform_later
end

scheduler.every "7d" do
  Rails.logger.info "Update eve characters"
  Eve::UpdateCharactersJob.perform_later
end

scheduler.join
