# frozen_string_literal: true

module Eve
  class ServerStatusImporter < BaseImporter
    def import
      import! do
        return if esi.not_modified?

        Eve::ServerStatus.create!(esi.as_json)

        update_etag
      end
    end

    def esi
      @esi ||= EveOnline::ESI::ServerStatus.new
    end
  end
end
