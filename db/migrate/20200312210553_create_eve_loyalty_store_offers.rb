# frozen_string_literal: true

class CreateEveLoyaltyStoreOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :eve_loyalty_store_offers do |t|
      t.bigint :offer_id
      t.bigint :ak_cost
      t.bigint :isk_cost
      t.bigint :lp_cost
      t.bigint :quantity
      t.bigint :type_id

      t.timestamps
    end
  end
end
