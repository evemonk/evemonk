# frozen_string_literal: true

module Eve
  class CharacterImporterWorker
    include Sidekiq::Worker

    def perform(character_id)
      Eve::CharacterImporter.new(character_id).import
    end
  end
end
