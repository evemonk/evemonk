# frozen_string_literal: true

module Eve
  class UpdateAlliancesCorporationsJob < ApplicationJob
    queue_as :default

    def perform
      if Rails.configuration.evemonk.jobs[:eve][:update_alliances_corporations]
        Eve::AlliancesCorporationsImporter.new.import
      end
    end
  end
end
