# frozen_string_literal: true

module Eve
  class LocalPlanetsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalPlanetsImporter.new.import
    end
  end
end
