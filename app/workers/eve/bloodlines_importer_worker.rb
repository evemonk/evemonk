# frozen_string_literal: true

module Eve
  class BloodlinesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::BloodlinesImporter.new.import
    end
  end
end
