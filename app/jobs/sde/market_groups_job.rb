# frozen_string_literal: true

module Sde
  class MarketGroupsJob < ApplicationJob
    queue_as :default

    def perform(file)
      MarketGroupsImporter.new(file).import
    end
  end
end
