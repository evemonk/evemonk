# frozen_string_literal: true

module Eve
  class CorporationImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      eve_corporation = Eve::Corporation.find_or_initialize_by(corporation_id: corporation_id)

      eveonline_esi_corporation = EveOnline::ESI::Corporation.new(corporation_id: corporation_id)

      etag = Etag.find_or_initialize_by(url: eveonline_esi_corporation.url)

      eveonline_esi_corporation.etag = etag.etag

      return if eveonline_esi_corporation.not_modified?

      eve_corporation.update!(eveonline_esi_corporation.as_json)

      etag.update!(etag: eveonline_esi_corporation.etag)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_corporation.destroy!
    end
  end
end
