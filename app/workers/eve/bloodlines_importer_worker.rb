# frozen_string_literal: true

module Eve
  class BloodlinesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::BloodlinesImporter.new(locale).import
      end
    end
  end
end
