# frozen_string_literal: true

class CharacterStandingsImporter < CharacterBaseImporter
  def import!
    esi.standings.each do |standing|
      character_standing = character.standings.find_or_initialize_by(from_id: standing.from_id,
        from_type: standing.from_type)

      case standing.from_type
      when "faction"
        standingable = Eve::Faction.find_by(faction_id: standing.from_id)
      when "npc_corp"
        standingable = Eve::Corporation.find_by(corporation_id: standing.from_id)
      when "agent"
        standingable = Eve::Agent.find_by(id: standing.from_id)
      else
        raise "Unknown standing from type"
      end

      character_standing.assign_attributes(standingable: standingable,
        standing: standing.standing)
      character_standing.save!
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterStandings.new(character_id: character.character_id)
  end
end
