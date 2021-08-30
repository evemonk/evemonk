# frozen_string_literal: true

module Eve
  class AllianceLogoImporter < BaseImporter
    attr_reader :alliance_id

    ALLIANCES_LOGO_URL = "https://images.evetech.net/alliances/%s/logo"

    def initialize(alliance_id)
      @alliance_id = alliance_id
    end

    def import
      eve_alliance = Eve::Alliance.find_or_initialize_by(alliance_id: alliance_id)

      tempfile = Down.download(ALLIANCES_LOGO_URL % alliance_id)

      eve_alliance.logo.attach(io: tempfile, filename: "#{alliance_id}.png")

      eve_alliance.save!
    end
  end
end
