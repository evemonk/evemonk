# frozen_string_literal: true

module Eve
  class AlliancesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::AlliancesImporter.new.import
    end
  end
end
