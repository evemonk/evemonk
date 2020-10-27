# frozen_string_literal: true

module Eve
  class ServerStatusImporter < BaseImporter
    def import!
      Eve::ServerStatus.create!(esi.as_json)
    end

    def esi
      @esi ||= EveOnline::ESI::ServerStatus.new
    end
  end
end
