# frozen_string_literal: true

class CreateCharacterBlueprints < ActiveRecord::Migration[6.0]
  def change
    create_table :character_blueprints do |t|
      t.references :character, null: false, foreign_key: true
      t.bigint :item_id
      t.string :location_flag
      t.bigint :location_id
      t.integer :material_efficiency
      t.integer :quantity
      t.integer :runs
      t.integer :time_efficiency
      t.bigint :type_id

      t.timestamps
    end
  end
end
