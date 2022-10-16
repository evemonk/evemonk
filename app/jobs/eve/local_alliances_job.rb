# frozen_string_literal: true

module Eve
  class LocalAlliancesJob < ApplicationJob
    queue_as :default

    def perform
      if Flipper.enabled?(:eve_local_alliances_job)
        Eve::LocalAlliancesImporter.new.import
      end
    end
  end
end
