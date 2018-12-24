# frozen_string_literal: true

module Eve
  class RemoveOldAlliancesImporter
    def import
      current_etag = Redis.current.get("remove_old_alliances:#{ I18n.locale }:etag")

      eveonline_esi_alliances = EveOnline::ESI::Alliances.new(etag: current_etag)

      return if eveonline_esi_alliances.not_modified?

      eve_alliance_ids = Eve::Alliance.pluck(:alliance_id)

      alliance_ids_to_remove = eve_alliance_ids - eveonline_esi_alliances.alliance_ids

      alliance_ids_to_remove.each do |alliance_id|
        eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

        eve_alliance.corporations.each do |corporation|
          Eve::CorporationImporter.new(corporation.corporation_id).import
        end

        eve_alliance.destroy!
      end

      Redis.current.set("remove_old_alliances:#{ I18n.locale }:etag", eveonline_esi_alliances.etag)
    end
  end
end
