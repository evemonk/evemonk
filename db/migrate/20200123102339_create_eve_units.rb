# frozen_string_literal: true

class CreateEveUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_units do |t|
      t.bigint :unit_id
      t.text :description
      t.string :unit_name
      t.string :display_name

      t.timestamps
    end

    add_index :eve_units, :unit_id, unique: true
  end
end
