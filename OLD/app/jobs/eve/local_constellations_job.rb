# frozen_string_literal: true

module Eve
  class LocalConstellationsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalConstellationsImporter.new.import
    end
  end
end
