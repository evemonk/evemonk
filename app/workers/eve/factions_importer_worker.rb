# frozen_string_literal: true

module Eve
  class FactionsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::FactionsImporter.new.import
    end
  end
end
