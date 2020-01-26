# frozen_string_literal: true

class CharacterStandingsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterStandings.new(character_id: character.character_id,
                                                 token: character.access_token)

    return unless character_scope_present?(esi.scope)

    esi.standings.each do |standing|
      character_standing = character.standings.find_or_initialize_by(from_id: standing.from_id,
                                                                     from_type: standing.from_type)

      character_standing.assign_attributes(standing: standing.standing)
      character_standing.save!
    end
  end
end
