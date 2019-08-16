# frozen_string_literal: true

module Eve
  class ServerStatusImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::ServerStatusImporter.new.import
    end
  end
end
