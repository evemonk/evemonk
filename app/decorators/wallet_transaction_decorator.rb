# frozen_string_literal: true

class WalletTransactionDecorator < ApplicationDecorator
  include LocationableDecorator

  decorates_associations :character, :type, :wallet_journal, :client, :location
end
