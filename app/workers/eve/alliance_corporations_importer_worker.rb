# frozen_string_literal: true

module Eve
  class AllianceCorporationsImporterWorker
    include Sidekiq::Worker

    def perform(alliance_id)
      Eve::AllianceCorporationsImporter.new(alliance_id).import
    end
  end
end
