# frozen_string_literal: true

module Eve
  class RacesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::RacesImporter.new.import
    end
  end
end
