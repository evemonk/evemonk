# frozen_string_literal: true

module Eve
  class UpdateCorporationsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::CorporationsImporter.new.import
    end
  end
end
