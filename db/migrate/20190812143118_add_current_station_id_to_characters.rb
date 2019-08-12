# frozen_string_literal: true

class AddCurrentStationIdToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :current_station_id, :bigint
  end
end
