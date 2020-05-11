# frozen_string_literal: true

class CreateEveRequiredItems < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_required_items do |t|
      t.references :eve_loyalty_store_offer, null: false, foreign_key: true
      t.integer :quantity
      t.bigint :type_id

      t.timestamps
    end
  end
end
