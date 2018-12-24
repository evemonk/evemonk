# frozen_string_literal: true

module Eve
  class AllianceImporterWorker
    include Sidekiq::Worker

    def perform(alliance_id)
      Eve::AllianceImporter.new(alliance_id).import
    end
  end
end
