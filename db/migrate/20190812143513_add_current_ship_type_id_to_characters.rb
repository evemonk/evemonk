# frozen_string_literal: true

class AddCurrentShipTypeIdToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :current_ship_type_id, :bigint
  end
end
