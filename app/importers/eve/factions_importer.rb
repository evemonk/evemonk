# frozen_string_literal: true

module Eve
  class FactionsImporter
    def import
      current_etag = Redis.current.get("factions:#{ I18n.locale }:etag")

      eveonline_esi_factions = EveOnline::ESI::UniverseFactions.new(etag: current_etag)

      return if eveonline_esi_factions.not_modified?

      eveonline_esi_factions.factions.each do |faction|
        eve_faction = Eve::Faction.find_or_initialize_by(faction_id: faction.faction_id)

        eve_faction.assign_attributes(faction.as_json)

        eve_faction.save! if eve_faction.changed?
      end

      Redis.current.set("factions:#{ I18n.locale }:etag", eveonline_esi_factions.etag)
    end
  end
end
