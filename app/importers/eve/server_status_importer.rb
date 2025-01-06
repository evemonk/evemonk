# frozen_string_literal: true

module Eve
  class ServerStatusImporter < BaseImporter
    def import
      import! do
        Eve::ServerStatus.create!(esi.as_json)
      end
    end

    private

    def esi
      @esi ||= EveOnline::ESI::ServerStatus.new(cache: Rails.cache)
    end
  end
end
