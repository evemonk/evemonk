# frozen_string_literal: true

# TODO: update
module Eve
  class CorporationAllianceHistoryImporter < BaseImporter
    attr_reader :corporation_id

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      import! do
        return if esi.not_modified?

        eve_corporation = Eve::Corporation.find_by!(corporation_id: corporation_id)

        esi.entries.each do |entry|
          history = eve_corporation.corporation_alliance_histories
            .find_or_initialize_by(record_id: entry.record_id)

          history.update!(entry.as_json)
        end

        update_etag
      rescue ActiveRecord::RecordNotFound
        Rails.logger.info("Corporation with ID #{corporation_id} not found")
      end
    end

    def esi
      @esi ||= EveOnline::ESI::CorporationAllianceHistory.new(corporation_id: corporation_id)
    end
  end
end
