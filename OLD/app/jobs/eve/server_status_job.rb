# frozen_string_literal: true

module Eve
  class ServerStatusJob < ApplicationJob
    queue_as :server_status

    sidekiq_options retry: false

    def perform
      if Rails.configuration.evemonk.jobs[:eve][:server_status]
        Eve::ServerStatusImporter.new.import
      end
    end
  end
end
