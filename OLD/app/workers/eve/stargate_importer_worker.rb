# frozen_string_literal: true

module Eve
  class StargateImporterWorker
    include Sidekiq::Worker

    def perform(stargate_id)
      Eve::StargateImporter.new(stargate_id).import
    end
  end
end
