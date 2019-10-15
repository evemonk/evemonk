# frozen_string_literal: true

class CreateEveIcons < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_icons do |t|
      t.integer :icon_id
      t.text :description
      t.string :icon_file
      t.boolean :obsolete
      t.string :backgrounds, array: true
      t.string :foregrounds, array: true

      t.timestamps
    end
  end
end
