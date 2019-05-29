# frozen_string_literal: true

module Eve
  class LocalTypesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::LocalTypesImporter.new.import
    end
  end
end
