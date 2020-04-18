# frozen_string_literal: true

class CharacterOrdersImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterOrders.new(character_id: character.character_id,
                                              token: character.access_token)

    return unless character_scope_present?(esi.scope)

    esi.orders.each do |order|
      character_order = character.character_orders.find_or_initialize_by(order_id: order.order_id)
      character_order.assign_attributes(order.as_json)
      character_order.save!
    end
  end
end
