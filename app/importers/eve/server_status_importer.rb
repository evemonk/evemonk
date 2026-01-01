# frozen_string_literal: true

module Eve
  class ServerStatusImporter < BaseImporter
    def import
      import! do
        Eve::ServerStatus.create!(server_status.as_json)
      end
    end

    private

    def server_status
      @server_status ||= client.server_status.info
    end

    def client
      @client ||= EveOnline::ESI::Client.new(cache: true, cache_store: Rails.cache)
    end
  end
end
