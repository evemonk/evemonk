# frozen_string_literal: true

class CreateWalletJournals < ActiveRecord::Migration[6.0]
  def change
    create_table :wallet_journals do |t|
      t.references :character, null: false, foreign_key: true
      t.float :amount
      t.float :balance
      t.bigint :context_id
      t.string :context_id_type
      t.datetime :date
      t.string :description
      t.bigint :first_party_id
      t.bigint :wallet_journal_id
      t.text :reason
      t.string :ref_type
      t.bigint :second_party_id
      t.float :tax
      t.bigint :tax_receiver_id

      t.timestamps
    end
  end
end
