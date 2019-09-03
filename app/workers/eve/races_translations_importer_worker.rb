# frozen_string_literal: true

module Eve
  class RacesTranslationsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::RacesTranslationsImporter.new.import
    end
  end
end
