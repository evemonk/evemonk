# frozen_string_literal: true

class CharacterShipImporter
  include CharacterAccessToken

  attr_reader :character_id, :character

  def initialize(character_id)
    @character_id = character_id
  end

  def import
    ActiveRecord::Base.transaction do
      character = Character.lock.find_by!(character_id: character_id)

      refresh_character_access_token(character)

      esi = EveOnline::ESI::CharacterShip.new(character_id: character.character_id,
                                              token: character.access_token)

      return unless character.scopes.include?(esi.scope)

      character.update!(current_ship_item_id: esi.ship_item_id,
                        current_ship_name: esi.ship_name,
                        current_ship_type_id: esi.ship_type_id)
    end
  rescue ActiveRecord::RecordNotFound
    Rails.logger.info("Character with ID #{character_id} not found")
  end
end
