# frozen_string_literal: true

module Eve
  class FactionsImporter
    def import
      ActiveRecord::Base.transaction do
        esi = EveOnline::ESI::UniverseFactions.new

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        esi.factions.each do |faction|
          eve_faction = Eve::Faction.find_or_initialize_by(faction_id: faction.faction_id)

          eve_faction.update!(faction.as_json)
        end

        etag.update!(etag: esi.etag)
      end
    end
  end
end
