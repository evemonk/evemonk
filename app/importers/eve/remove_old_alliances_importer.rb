# frozen_string_literal: true

module Eve
  class RemoveOldAlliancesImporter
    def import
      etag = Redis.current.get("remove_old_alliances:#{ I18n.locale }:etag")

      alliances = EveOnline::ESI::Alliances.new(etag: etag)

      return if alliances.not_modified?

      alliance_ids = Eve::Alliance.pluck(:alliance_id)

      alliance_ids_to_remove = alliance_ids - alliances.alliance_ids

      alliance_ids_to_remove.each do |alliance_id|
        alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

        alliance.corporations.each do |corporation|
          Eve::CorporationImporter.new(corporation.corporation_id).import
        end

        alliance.destroy!
      end

      Redis.current.set("remove_old_alliances:#{ I18n.locale }:etag", alliances.etag)
    end
  end
end
