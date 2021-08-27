# frozen_string_literal: true

module Eve
  class LocalGroupsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalGroupsImporter.new.import
    end
  end
end
