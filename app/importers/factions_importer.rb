# frozen_string_literal: true

class FactionsImporter
  def import
    factions = EveOnline::ESI::Factions.new

    factions.factions.each do |faction|
      Eve::Faction.create!(faction.as_json)
    end
  end
end
