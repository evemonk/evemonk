# frozen_string_literal: true

module Eve
  class UpdateCorporationLogoJob < ApplicationJob
    queue_as :default

    retry_on Down::TimeoutError,
      Down::ConnectionError

    def perform(corporation_id)
      Eve::CorporationLogoImporter.new(corporation_id).import
    end
  end
end
