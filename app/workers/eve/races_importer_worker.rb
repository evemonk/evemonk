# frozen_string_literal: true

module Eve
  class RacesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::RacesImporter.new(locale).import
      end
    end
  end
end
