# frozen_string_literal: true

module Eve
  class UpdateAllianceLogoJob < ApplicationJob
    queue_as :default

    retry_on Down::TimeoutError,
      Down::ConnectionError

    def perform(alliance_id)
      Eve::AllianceLogoImporter.new(alliance_id).import
    end
  end
end
