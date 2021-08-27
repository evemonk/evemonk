# frozen_string_literal: true

module Eve
  class LocalRegionsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalRegionsImporter.new.import
    end
  end
end
