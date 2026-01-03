# frozen_string_literal: true

module Eve
  class ServerStatusJob < ApplicationJob
    queue_as :server_status

    def perform
      if Flipper.enabled?(:eve_server_status)
        Eve::ServerStatusImporter.new.import
      end
    end
  end
end
