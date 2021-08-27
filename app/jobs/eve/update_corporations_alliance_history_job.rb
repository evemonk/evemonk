# frozen_string_literal: true

module Eve
  class UpdateCorporationsAllianceHistoryJob < ApplicationJob
    queue_as :default

    def perform
      Eve::CorporationsAllianceHistoryImporter.new.import
    end
  end
end
