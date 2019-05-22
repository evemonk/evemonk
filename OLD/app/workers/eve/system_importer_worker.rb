# frozen_string_literal: true

module Eve
  class SystemImporterWorker
    include Sidekiq::Worker

    def perform(system_id)
      Eve::SystemImporter.new(system_id).import
    end
  end
end
