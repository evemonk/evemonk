# frozen_string_literal: true

module Eve
  class LocalAlliancesJob < ApplicationJob
    queue_as :default

    def perform
      if Rails.configuration.evemonk.jobs[:eve][:local_alliances]
        Eve::LocalAlliancesImporter.new.import
      end
    end
  end
end
