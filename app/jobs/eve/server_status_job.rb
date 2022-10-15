# frozen_string_literal: true

module Eve
  class ServerStatusJob < ApplicationJob
    queue_as :server_status

    sidekiq_options retry: false

    def perform
      if Flipper.enabled?(:eve_server_status_job)
        Eve::ServerStatusImporter.new.import
      end
    end
  end
end
