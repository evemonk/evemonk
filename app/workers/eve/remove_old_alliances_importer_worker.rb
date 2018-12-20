# frozen_string_literal: true

module Eve
  class RemoveOldAlliancesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::RemoveOldAlliancesImporter.new.import
    end
  end
end
