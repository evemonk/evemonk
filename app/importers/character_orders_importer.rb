# frozen_string_literal: true

class CharacterOrdersImporter < CharacterBaseImporter
  def import!
    esi.orders.each do |order|
      character_order = character.character_orders.find_or_initialize_by(order_id: order.order_id)
      character_order.assign_attributes(order.as_json)
      character_order.save!
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterOrders.new(character_id: character.character_id)
  end
end
