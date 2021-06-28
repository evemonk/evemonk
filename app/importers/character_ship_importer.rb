# frozen_string_literal: true

class CharacterShipImporter < CharacterBaseImporter
  def import!
    character.update!(current_ship_item_id: esi.ship_item_id,
      current_ship_name: esi.ship_name,
      current_ship_type_id: esi.ship_type_id)
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterShip.new(character_id: character.character_id)
  end
end
