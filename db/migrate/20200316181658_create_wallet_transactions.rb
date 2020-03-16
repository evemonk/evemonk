# frozen_string_literal: true

class CreateWalletTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :wallet_transactions do |t|
      t.references :character, null: false, foreign_key: true
      t.bigint :client_id
      t.datetime :date
      t.boolean :is_buy
      t.boolean :is_personal
      t.bigint :journal_ref_id
      t.bigint :location_id
      t.integer :quantity
      t.bigint :transaction_id
      t.bigint :type_id
      t.float :unit_price

      t.timestamps
    end
  end
end
