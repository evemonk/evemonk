# frozen_string_literal: true

module Eve
  class TypeImporterWorker
    include Sidekiq::Worker

    def perform(type_id)
      Eve::TypeImporter.new(type_id).import
    end
  end
end
