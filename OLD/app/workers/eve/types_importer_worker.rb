# frozen_string_literal: true

module Eve
  class TypesImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::TypesImporter.new.import
    end
  end
end
