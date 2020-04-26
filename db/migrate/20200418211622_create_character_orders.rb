# frozen_string_literal: true

class CreateCharacterOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :character_orders do |t|
      t.references :character, null: false, foreign_key: true
      t.integer :duration
      t.float :escrow
      t.boolean :is_buy_order
      t.boolean :is_corporation
      t.datetime :issued
      t.bigint :location_id
      t.integer :min_volume
      t.bigint :order_id
      t.float :price
      t.string :range
      t.bigint :region_id
      t.bigint :type_id
      t.integer :volume_remain
      t.integer :volume_total

      t.timestamps
    end
  end
end
