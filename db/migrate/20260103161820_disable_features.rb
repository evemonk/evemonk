# frozen_string_literal: true

class DisableFeatures < ActiveRecord::Migration[8.1]
  def change
    # Disable pghero
    Flipper.disable :pghero

    # Disable external calls to ESI server status
    Flipper.disable :eve_server_status

    # Disable external calls to ESI races
    Flipper.disable :eve_races

    # Disable external calls to ESI bloodlines
    Flipper.disable :eve_bloodlines

    # Disable external calls to ESI ancestries
    Flipper.disable :eve_ancestries

    # Disable external calls to ESI factions
    Flipper.disable :eve_factions
  end
end
