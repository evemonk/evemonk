# frozen_string_literal: true

class AddIndexWalletJournalsOnWalletJournalId < ActiveRecord::Migration[6.0]
  def change
    add_index :wallet_journals, :wallet_journal_id
  end
end
