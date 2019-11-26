# frozen_string_literal: true

module Eve
  class AncestriesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::AncestriesImporter.new(locale).import
      end
    end
  end
end
