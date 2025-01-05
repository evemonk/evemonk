# frozen_string_literal: true

module Eve
  class LocalAsteroidBeltsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalAsteroidBeltsImporter.new.import
    end
  end
end
