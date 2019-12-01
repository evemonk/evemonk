# frozen_string_literal: true

class CharacterLocationImporter
  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    character = Character.find_by!(character_id: character_id)

    esi = EveOnline::ESI::CharacterLocation.new(character_id: character_id,
                                                token: character.access_token)

    character.update!(current_solar_system_id: esi.solar_system_id,
                      current_station_id: esi.station_id,
                      current_structure_id: esi.structure_id)
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
