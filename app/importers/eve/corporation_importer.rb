# frozen_string_literal: true

module Eve
  class CorporationImporter < BaseImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      import! do
        return if esi.not_modified?

        input = CorporationInput.new(esi.as_json.merge(corporation_id: corporation_id))

        CorporationRepository.update(corporation_id, input)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Corporation ID #{corporation_id}")

        EtagRepository.destroy(esi.url)
        CorporationRepository.destroy(corporation_id)
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Corporation.new(corporation_id: corporation_id)
    end
  end
end
