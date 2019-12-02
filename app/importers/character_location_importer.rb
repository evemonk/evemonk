# frozen_string_literal: true

class CharacterLocationImporter
  include CharacterAccessToken

  attr_reader :character_id, :character

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.lock.find_by!(character_id: character_id)

      refresh_character_access_token(character)

      esi = EveOnline::ESI::CharacterLocation.new(character_id: character.character_id,
                                                  token: character.access_token)

      return unless character.scopes.include?(esi.scope)

      character.update!(current_solar_system_id: esi.solar_system_id,
                        current_station_id: esi.station_id,
                        current_structure_id: esi.structure_id)
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
