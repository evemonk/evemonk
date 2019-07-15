# frozen_string_literal: true

module Eve
  class CorporationImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_corporation = Eve::Corporation.find_or_initialize_by(corporation_id: corporation_id)

        esi = EveOnline::ESI::Corporation.new(corporation_id: corporation_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_corporation.update!(esi.as_json)

        etag.update!(etag: esi.etag)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_corporation.destroy!
      end
    end
  end
end
