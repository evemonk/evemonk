# frozen_string_literal: true

module Eve
  class SystemsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::SystemsImporter.new.import
    end
  end
end
