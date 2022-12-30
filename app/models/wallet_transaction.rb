# frozen_string_literal: true

class WalletTransaction < ApplicationRecord
  include Locationable

  belongs_to :character

  belongs_to :type, class_name: "Eve::Type", optional: true

  belongs_to :wallet_journal,
    primary_key: "wallet_journal_id",
    foreign_key: "journal_ref_id",
    optional: true

  belongs_to :client,
    class_name: "Eve::Character",
    primary_key: "character_id",
    foreign_key: "client_id",
    optional: true
end
