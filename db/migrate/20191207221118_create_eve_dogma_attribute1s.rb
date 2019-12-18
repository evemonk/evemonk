# frozen_string_literal: true

class CreateEveDogmaAttribute1s < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_dogma_attributes do |t|
      t.bigint :attribute_id
      t.float :default_value
      t.string :description
      t.string :display_name
      t.boolean :high_is_good
      t.bigint :icon_id
      t.string :name
      t.boolean :published
      t.boolean :stackable
      t.bigint :unit_id

      t.timestamps
    end
  end
end
