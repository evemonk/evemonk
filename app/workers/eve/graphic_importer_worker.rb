# frozen_string_literal: true

module Eve
  class GraphicImporterWorker
    include Sidekiq::Worker

    def perform(graphic_id)
      Eve::GraphicImporter.new(graphic_id).import
    end
  end
end
