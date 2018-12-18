# frozen_string_literal: true

class CreateEveBloodlinesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_bloodlines do |t|
      t.bigint :bloodline_id
      t.integer :charisma
      t.bigint :corporation_id
      t.text :description
      t.integer :intelligence
      t.integer :memory
      t.string :name
      t.integer :perception
      t.bigint :race_id
      t.bigint :ship_type_id
      t.integer :willpower
      t.timestamps
      t.index :bloodline_id, unique: true
    end
  end
end
