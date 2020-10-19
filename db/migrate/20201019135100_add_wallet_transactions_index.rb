# frozen_string_literal: true

class AddWalletTransactionsIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :wallet_transactions, :transaction_id
  end
end
