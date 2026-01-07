# frozen_string_literal: true

class AddMoreFeatureFlags < ActiveRecord::Migration[8.1]
  def change
    # Disable external calls to ESI character
    Flipper.disable :eve_character

    # Disable external calls to ESI character assets
    Flipper.disable :eve_character_assets

    # Disable external calls to ESI character online status
    Flipper.disable :eve_character_online

    # Disable external calls to ESI character ship
    Flipper.disable :eve_character_ship

    # Disable external calls to ESI corporation
    Flipper.disable :eve_corporation

    # Disable external calls to ESI alliance
    Flipper.disable :eve_alliance

    # Disable external calls to ESI alliances
    Flipper.disable :eve_alliances
  end
end
