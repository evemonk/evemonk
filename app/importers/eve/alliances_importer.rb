# frozen_string_literal: true

module Eve
  class AlliancesImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::Alliances.new
    end

    def import
      ActiveRecord::Base.transaction do
        esi.etag = etag.etag

        return if esi.not_modified?

        import_new_alliances

        remove_old_alliances

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    private

    def etag
      @etag ||= Eve::Etag.find_or_initialize_by(url: esi.url)
    end

    def import_new_alliances
      esi.alliance_ids.each do |alliance_id|
        unless Eve::Alliance.exists?(alliance_id: alliance_id)
          Eve::AllianceImporterWorker.perform_async(alliance_id)
        end
      end
    end

    def remove_old_alliances
      eve_alliance_ids = Eve::Alliance.pluck(:alliance_id)

      alliance_ids_to_remove = eve_alliance_ids - esi.alliance_ids

      alliance_ids_to_remove.each do |alliance_id|
        eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

        eve_alliance.corporations.each do |corporation|
          Eve::CorporationImporterWorker.perform_async(corporation.corporation_id)
        end

        eve_alliance.destroy!
      end
    end
  end
end
