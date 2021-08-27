# frozen_string_literal: true

module Eve
  class LocalCharactersJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalCharactersImporter.new.import
    end
  end
end
