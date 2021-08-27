# frozen_string_literal: true

module Eve
  class LocalAlliancesJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalAlliancesImporter.new.import
    end
  end
end
