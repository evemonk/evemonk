# frozen_string_literal: true

module Eve
  class AlliancesImporter < BaseImporter
    def import
      import! do
        return if esi.not_modified?

        remove_old_alliances

        import_new_alliances

        update_etag
      end
    end

    def esi
      @esi ||= EveOnline::ESI::Alliances.new
    end

    private

    def import_new_alliances
      eve_alliance_ids = Eve::Alliance.ids

      eve_alliance_ids_to_create = esi.alliance_ids - eve_alliance_ids

      eve_alliance_ids_to_create.each do |alliance_id|
        Eve::UpdateAllianceJob.perform_later(alliance_id)
      end
    end

    def remove_old_alliances
      eve_alliance_ids = Eve::Alliance.ids

      alliance_ids_to_remove = eve_alliance_ids - esi.alliance_ids

      alliance_ids_to_remove.each do |id|
        eve_alliance = Eve::Alliance.find_or_initialize_by(id: id)

        eve_alliance.corporations.each do |corporation|
          Eve::UpdateCorporationJob.perform_later(corporation.corporation_id)
        end

        eve_alliance.destroy!
      end
    end
  end
end
