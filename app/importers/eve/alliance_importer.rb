# frozen_string_literal: true

module Eve
  class AllianceImporter
    attr_reader :alliance_id

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

        esi = EveOnline::ESI::Alliance.new(alliance_id: alliance_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_alliance.update!(esi.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_alliance.destroy!
      end
    end
  end
end
