# frozen_string_literal: true

class AddCurrentSolarSystemIdToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :current_solar_system_id, :bigint
  end
end
