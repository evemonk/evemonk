# frozen_string_literal: true

class CreateEveCharacterAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_character_attributes do |t|
      t.integer :attribute_id
      t.string :attribute_name
      t.text :description
      t.integer :icon_id
      t.text :notes
      t.text :short_description

      t.timestamps
    end
  end
end
