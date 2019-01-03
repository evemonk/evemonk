# frozen_string_literal: true

module Eve
  class CorporationsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::CorporationsImporter.new.import
    end
  end
end
