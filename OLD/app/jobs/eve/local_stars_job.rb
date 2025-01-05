# frozen_string_literal: true

module Eve
  class LocalStarsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalStarsImporter.new.import
    end
  end
end
