# frozen_string_literal: true

module Eve
  class LocalSystemsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalSystemsImporter.new.import
    end
  end
end
