# frozen_string_literal: true

class CharacterShipImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterShip.new(character_id: character.character_id,
                                            token: character.access_token)

    return unless character_scope_present?(esi.scope)

    character.update!(current_ship_item_id: esi.ship_item_id,
                      current_ship_name: esi.ship_name,
                      current_ship_type_id: esi.ship_type_id)
  end
end
