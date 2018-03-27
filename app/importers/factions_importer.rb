# frozen_string_literal: true

class FactionsImporter
  def import
    factions = EveOnline::ESI::Factions.new.factions

    factions.each do |faction|
      eve_faction = Eve::Faction.find_or_initialize_by(faction_id: faction.faction_id)

      eve_faction.update!(faction.as_json)
    end
  end
end
