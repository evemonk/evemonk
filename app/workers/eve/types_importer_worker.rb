# frozen_string_literal: true

module Eve
  class TypesImporterWorker
    include Sidekiq::Worker

    def perform(page = 1)
      Eve::TypesImporter.new(page).import
    end
  end
end
