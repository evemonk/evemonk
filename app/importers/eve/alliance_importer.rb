# frozen_string_literal: true

module Eve
  class AllianceImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

      eveonline_esi_alliance = EveOnline::ESI::Alliance.new(alliance_id: alliance_id,
                                                            etag: eve_alliance.etag)

      return if eveonline_esi_alliance.not_modified?

      eve_alliance.assign_attributes(eveonline_esi_alliance.as_json)

      eve_alliance.save! if eve_alliance.changed?
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_alliance.destroy! if eve_alliance.persisted?
    end
  end
end
