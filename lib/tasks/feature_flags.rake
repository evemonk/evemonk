# frozen_string_literal: true

namespace :evemonk do
  desc "Disable all feature flags"
  task feature_flags: :environment do
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

    # Disable internal certificates tab for character
    Flipper.disable :internal_certificates_tab

    # Disable internal training queue tab for character
    Flipper.disable :internal_training_queue_tab

    # Disable internal help tab for character
    Flipper.disable :internal_help_tab
  end
end
