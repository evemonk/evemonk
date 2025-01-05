# frozen_string_literal: true

module Eve
  class AllianceLogoImporter < BaseImporter
    attr_reader :id

    ALLIANCES_LOGO_URL = "https://images.evetech.net/alliances/%s/logo"

    def initialize(id)
      @id = id
    end

    def import
      eve_alliance = Eve::Alliance.find_or_initialize_by(id: id)

      tempfile = Down.download(ALLIANCES_LOGO_URL % id)

      eve_alliance.logo.attach(io: tempfile, filename: "#{id}.png")

      eve_alliance.save!
    end
  end
end
