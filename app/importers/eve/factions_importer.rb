# frozen_string_literal: true

module Eve
  class FactionsImporter
    def import
      eveonline_esi_factions = EveOnline::ESI::UniverseFactions.new

      etag = Etag.find_or_initialize_by(url: eveonline_esi_factions.url)

      eveonline_esi_factions.etag = etag.etag

      return if eveonline_esi_factions.not_modified?

      eveonline_esi_factions.factions.each do |faction|
        eve_faction = Eve::Faction.find_or_initialize_by(faction_id: faction.faction_id)

        eve_faction.update!(faction.as_json)
      end

      etag.update!(etag: eveonline_esi_factions.etag)
    end
  end
end
