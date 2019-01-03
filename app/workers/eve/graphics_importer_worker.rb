# frozen_string_literal: true

module Eve
  class GraphicsImporterWorker
    include Sidekiq::Worker

    def perform(*)
      Eve::GraphicsImporter.new.import
    end
  end
end
