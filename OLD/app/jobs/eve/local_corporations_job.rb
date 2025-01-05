# frozen_string_literal: true

module Eve
  class LocalCorporationsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalCorporationsImporter.new.import
    end
  end
end
