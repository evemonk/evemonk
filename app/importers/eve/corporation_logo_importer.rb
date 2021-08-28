# frozen_string_literal: true

module Eve
  class CorporationLogoImporter < BaseImporter
    attr_reader :corporation_id

    CORPORATIONS_LOGO_URL = "https://images.evetech.net/corporations/%s/logo"

    def initialize(corporation_id)
      @corporation_id = corporation_id
    end

    def import
      eve_corporation = Eve::Corporation.find_or_initialize_by(corporation_id: corporation_id)

      tempfile = Down.download(CORPORATIONS_LOGO_URL % corporation_id)

      eve_corporation.logo.attach(io: tempfile, filename: "#{corporation_id}.png")

      eve_corporation.save!
    end
  end
end
