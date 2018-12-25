# frozen_string_literal: true

module Eve
  class AncestriesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::AncestriesImporter.new.import
    end
  end
end
