# frozen_string_literal: true

module Eve
  class LocalTypesJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalTypesImporter.new.import
    end
  end
end
