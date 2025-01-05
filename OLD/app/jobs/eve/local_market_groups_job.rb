# frozen_string_literal: true

module Eve
  class LocalMarketGroupsJob < ApplicationJob
    queue_as :default

    def perform
      Eve::LocalMarketGroupsImporter.new.import
    end
  end
end
