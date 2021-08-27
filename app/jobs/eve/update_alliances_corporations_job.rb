# frozen_string_literal: true

module Eve
  class UpdateAlliancesCorporationsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::AlliancesCorporationsImporter.new.import
    end
  end
end
