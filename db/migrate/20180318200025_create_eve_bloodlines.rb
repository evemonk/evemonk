# frozen_string_literal: true

class CreateEveBloodlines < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_bloodlines do |t|
      t.integer :bloodline_id
      t.string :name
      t.text :description
      t.integer :race_id
      t.integer :ship_type_id
      t.integer :corporation_id
      t.integer :perception
      t.integer :willpower
      t.integer :charisma
      t.integer :memory
      t.integer :intelligence

      t.timestamps
    end
  end
end
