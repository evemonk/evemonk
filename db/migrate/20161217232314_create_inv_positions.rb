# frozen_string_literal: true
class CreateInvPositions < ActiveRecord::Migration[5.0]
  def change
    create_table :inv_positions do |t|
      t.integer :item_id
      t.float :pitch
      t.float :roll
      t.float :x
      t.float :y
      t.float :yaw
      t.float :z

      t.timestamps null: false
    end
  end
end
