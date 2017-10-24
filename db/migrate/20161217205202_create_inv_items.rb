# frozen_string_literal: true

class CreateInvItems < ActiveRecord::Migration[5.0]
  def change
    create_table :inv_items do |t|
      t.integer :flag_id
      t.integer :item_id
      t.integer :location_id
      t.integer :owner_id
      t.integer :quantity
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
