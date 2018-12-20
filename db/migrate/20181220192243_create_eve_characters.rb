# frozen_string_literal: true

class CreateEveCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_characters do |t|
      t.bigint :character_id
      t.bigint :alliance_id
      t.bigint :ancestry_id
      t.datetime :birthday
      t.bigint :bloodline_id
      t.bigint :corporation_id
      t.text :description
      t.bigint :faction_id
      t.string :gender
      t.string :name
      t.bigint :race_id
      t.float :security_status
      t.timestamps
      t.index :character_id, unique: true
    end
  end
end
