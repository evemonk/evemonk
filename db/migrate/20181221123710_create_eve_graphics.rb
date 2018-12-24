# frozen_string_literal: true

class CreateEveGraphics < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_graphics do |t|
      t.string :collision_file
      t.string :graphic_file
      t.bigint :graphic_id
      t.string :icon_folder
      t.string :sof_dna
      t.string :sof_fation_name
      t.string :sof_hull_name
      t.string :sof_race_name
      t.timestamps
      t.index :graphic_id, unique: true
    end
  end
end
