# frozen_string_literal: true

module Eve
  class AllianceImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

      eveonline_esi_alliance = EveOnline::ESI::Alliance.new(alliance_id: alliance_id)

      etag = Etag.find_or_initialize_by(url: eveonline_esi_alliance.url)

      eveonline_esi_alliance.etag = etag.etag

      return if eveonline_esi_alliance.not_modified?

      eve_alliance.update!(eveonline_esi_alliance.as_json)

      etag.update!(etag: eveonline_esi_alliance.etag)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_alliance.destroy!
    end
  end
end
