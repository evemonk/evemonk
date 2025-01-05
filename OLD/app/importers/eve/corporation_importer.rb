# frozen_string_literal: true

module Eve
  class CorporationImporter < BaseImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      import! do
        eve_corporation = Eve::Corporation.find_or_initialize_by(id: corporation_id)

        eve_corporation.update!(esi.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Corporation ID #{corporation_id}")

        eve_corporation.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Corporation.new(corporation_id: corporation_id)
    end
  end
end
