# frozen_string_literal: true

module Eve
  class AlliancesCorporationsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::AlliancesCorporationsImporter.new.import
    end
  end
end
