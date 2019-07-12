# frozen_string_literal: true

class CreateCharacterAssets < ActiveRecord::Migration[6.0]
  def change
    create_table :character_assets do |t|
      t.references :character, foreign_key: true
      t.boolean :is_blueprint_copy
      t.boolean :is_singleton
      t.bigint :item_id
      t.string :location_flag
      t.bigint :location_id
      t.string :location_type
      t.bigint :quantity
      t.bigint :type_id

      t.timestamps
    end
  end
end
