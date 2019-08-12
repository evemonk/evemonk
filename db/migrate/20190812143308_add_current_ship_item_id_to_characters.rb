# frozen_string_literal: true

class AddCurrentShipItemIdToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :current_ship_item_id, :bigint
  end
end
