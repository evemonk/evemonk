# frozen_string_literal: true

module Eve
  class UpdateCorporationLogoJob < ApplicationJob
    queue_as :default

    retry_on Down::TimeoutError,
      Down::ConnectionError

    def perform(id)
      Eve::CorporationLogoImporter.new(id).import
    end
  end
end
