# frozen_string_literal: true

module Eve
  class CorporationAllianceHistoryImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      eve_corporation = Eve::Corporation.find_by!(corporation_id: corporation_id)

      esi = EveOnline::ESI::CorporationAllianceHistory.new(corporation_id: corporation_id)

      etag = Eve::Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      esi.entries.each do |entry|
        history = eve_corporation.corporation_alliance_histories
                                 .find_or_initialize_by(record_id: entry.record_id)

        history.update!(entry.as_json)
      end

      etag.update!(etag: esi.etag)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_corporation.destroy!
    rescue ActiveRecord::RecordNotFound
      Rails.logger.info("Corporation with ID #{ corporation_id } not found")
    end
  end
end
