# frozen_string_literal: true

class CreateEvePositions < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_positions do |t|
      t.bigint :x
      t.bigint :y
      t.bigint :z
      t.bigint :positionable_id
      t.string :positionable_type

      t.timestamps
    end
  end
end
