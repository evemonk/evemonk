# frozen_string_literal: true

module Eve
  class LocalDogmaAttributesJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalDogmaAttributesImporter.new.import
    end
  end
end
