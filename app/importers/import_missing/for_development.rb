# frozen_string_literal: true

module ImportMissing
  class ForDevelopment
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
    end
  end
end
