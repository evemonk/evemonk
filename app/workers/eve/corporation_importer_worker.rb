# frozen_string_literal: true

module Eve
  class CorporationImporterWorker
    include Sidekiq::Worker

    def perform(corporation_id)
      Eve::CorporationImporter.new(corporation_id).import
      Eve::CorporationAllianceHistoryImporter.new(corporation_id).import
    end
  end
end
