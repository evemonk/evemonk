# frozen_string_literal: true

module Eve
  class LocalGraphicsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::LocalGraphicsImporter.new.import
    end
  end
end
