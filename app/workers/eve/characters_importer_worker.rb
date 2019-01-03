# frozen_string_literal: true

module Eve
  class CharactersImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::CharactersImporter.new.import
    end
  end
end
