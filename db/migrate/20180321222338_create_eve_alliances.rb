# frozen_string_literal: true

class CreateEveAlliances < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_alliances do |t|
      t.integer :alliance_id
      t.string :name
      t.integer :creator_id
      t.integer :creator_corporation_id
      t.string :ticker
      t.integer :executor_corporation_id
      t.datetime :date_founded
      t.integer :faction_id

      t.timestamps
    end
  end
end
