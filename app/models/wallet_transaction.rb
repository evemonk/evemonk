# frozen_string_literal: true

class WalletTransaction < ApplicationRecord
  belongs_to :character

  belongs_to :type,
    class_name: "Eve::Type",
    primary_key: "type_id",
    foreign_key: "type_id",
    optional: true

  belongs_to :wallet_journal,
    primary_key: "wallet_journal_id",
    foreign_key: "journal_ref_id",
    optional: true
end
