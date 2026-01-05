# frozen_string_literal: true

class DisableCharacterWallet < ActiveRecord::Migration[8.1]
  def change
    # Disable external calls to ESI character wallet
    Flipper.disable :eve_character_wallet
  end
end
