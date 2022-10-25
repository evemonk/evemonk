# frozen_string_literal: true

module Eve
  class UpdateAlliancesCorporationsJob < ApplicationJob
    queue_as :default

    def perform
      if Flipper.enabled?(:eve_update_alliances_corporations_job)
        Eve::AlliancesCorporationsImporter.new.import
      end
    end
  end
end
