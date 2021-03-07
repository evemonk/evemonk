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
      eve_alliance_ids_to_create = esi.alliance_ids - eve_alliance_ids

      eve_alliance_ids_to_create.each do |alliance_id|
        Eve::UpdateAllianceJob.perform_later(alliance_id)
      end
    end

    def remove_old_alliances
      alliance_ids_to_remove = eve_alliance_ids - esi.alliance_ids

      alliance_ids_to_remove.each do |alliance_id|
        begin
          eve_alliance = AllianceRepository.find_by_alliance_id(alliance_id)

          eve_alliance.corporation_ids.each do |corporation_id|
            Eve::UpdateCorporationJob.perform_later(corporation_id)
          end

          AllianceRepository.destroy(alliance_id)
        rescue ActiveRecord::RecordNotFound
          Rails.logger.info("Alliance ID #{alliance_id} not found")
        end
      end
    end

    def eve_alliance_ids
      @eve_alliance_ids ||= AllianceRepository.alliance_ids
    end
  end
end
