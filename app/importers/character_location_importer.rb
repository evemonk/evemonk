# frozen_string_literal: true

class CharacterLocationImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token(character)

    esi = EveOnline::ESI::CharacterLocation.new(character_id: character.character_id,
                                                token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.update!(current_solar_system_id: esi.solar_system_id,
                      current_station_id: esi.station_id,
                      current_structure_id: esi.structure_id)
  end
end
