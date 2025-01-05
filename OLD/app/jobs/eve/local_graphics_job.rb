# frozen_string_literal: true

module Eve
  class LocalGraphicsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalGraphicsImporter.new.import
    end
  end
end
