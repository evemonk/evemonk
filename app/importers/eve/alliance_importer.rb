# frozen_string_literal: true

module Eve
  class AllianceImporter < BaseImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import!
      eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

      eve_alliance.update!(esi.as_json)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_alliance.destroy!
    end

    def esi
      @esi ||= EveOnline::ESI::Alliance.new(alliance_id: alliance_id)
    end
  end
end
