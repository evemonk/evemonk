# frozen_string_literal: true

class AddCurrentShipNameToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :current_ship_name, :string
  end
end
