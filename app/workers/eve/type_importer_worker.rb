# frozen_string_literal: true

module Eve
  class TypeImporterWorker
    include Sidekiq::Worker

    def perform(type_id)
      LanguageMapper::LANGUAGES.each_key do |locale|
        Eve::TypeImporter.new(type_id, locale).import
      end
    end
  end
end
