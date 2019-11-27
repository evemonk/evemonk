# frozen_string_literal: true

module Eve
  class FactionsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::FactionsImporter.new(locale).import
      end
    end
  end
end
