# frozen_string_literal: true

class AddCorporationIdToEveLoyaltyStoreOffers < ActiveRecord::Migration[6.0]
  def change
    add_column :eve_loyalty_store_offers, :corporation_id, :bigint
    add_index :eve_loyalty_store_offers, :corporation_id
  end
end
