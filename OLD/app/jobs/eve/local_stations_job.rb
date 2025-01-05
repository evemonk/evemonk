# frozen_string_literal: true

module Eve
  class LocalStationsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalStationsImporter.new.import
    end
  end
end
