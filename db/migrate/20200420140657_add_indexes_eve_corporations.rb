# frozen_string_literal: true

class AddIndexesEveCorporations < ActiveRecord::Migration[6.0]
  def change
    add_index :eve_corporations, :ceo_id
    add_index :eve_corporations, :creator_id
    add_index :eve_corporations, :faction_id
    add_index :eve_corporations, :home_station_id
  end
end
