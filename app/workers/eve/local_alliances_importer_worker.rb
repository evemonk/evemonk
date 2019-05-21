# frozen_string_literal: true

module Eve
  class LocalAlliancesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::LocalAlliancesImporter.new.import
    end
  end
end
