# frozen_string_literal: true

class CharacterLocationImporter < CharacterBaseImporter
  def import!
    character.update!(current_solar_system_id: esi.solar_system_id,
      current_station_id: esi.station_id,
      current_structure_id: esi.structure_id)
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterLocation.new(character_id: character.character_id)
  end
end
