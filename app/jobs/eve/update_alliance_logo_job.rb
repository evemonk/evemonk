# frozen_string_literal: true

module Eve
  class UpdateAllianceLogoJob < ApplicationJob
    queue_as :default

    retry_on Down::TimeoutError,
      Down::ConnectionError

    def perform(id)
      if Rails.configuration.evemonk.jobs[:eve][:update_alliance_logo]
        Eve::AllianceLogoImporter.new(id).import
      end
    end
  end
end
