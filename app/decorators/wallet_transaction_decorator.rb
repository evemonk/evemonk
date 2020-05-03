# frozen_string_literal: true

class WalletTransactionDecorator < ApplicationDecorator
  decorates_associations :character, :type
end
