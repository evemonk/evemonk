# frozen_string_literal: true

class RemoveEveRaces < ActiveRecord::Migration[5.2]
  def change
    drop_table :eve_races do |t|
      t.text :description
      t.integer :race_id
      t.string :name
      t.timestamps
      t.integer :alliance_id
      t.index :race_id, unique: true
    end
  end
end
