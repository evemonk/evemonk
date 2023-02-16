# frozen_string_literal: true

module Eve
  class CorporationLogoImporter < BaseImporter
    attr_reader :id

    CORPORATIONS_LOGO_URL = "https://images.evetech.net/corporations/%s/logo"

    def initialize(id)
      @id = id
    end

    def import
      eve_corporation = Eve::Corporation.find_or_initialize_by(id: id)

      tempfile = Down.download(CORPORATIONS_LOGO_URL % id)

      eve_corporation.logo.attach(io: tempfile, filename: "#{id}.png")

      eve_corporation.save!
    end
  end
end
