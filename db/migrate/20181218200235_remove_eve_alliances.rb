# frozen_string_literal: true

class RemoveEveAlliances < ActiveRecord::Migration[5.2]
  def change
    drop_table :eve_alliances do |t|
      t.integer :alliance_id
      t.string :name
      t.integer :creator_id
      t.integer :creator_corporation_id
      t.string :ticker
      t.integer :executor_corporation_id
      t.datetime :date_founded
      t.integer :faction_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :icon_small
      t.string :icon_medium
      t.index [:alliance_id], name: "index_eve_alliances_on_alliance_id", unique: true
    end
  end
end
