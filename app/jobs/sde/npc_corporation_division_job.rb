# frozen_string_literal: true

module Sde
  class NpcCorporationDivisionJob < ApplicationJob
    queue_as :default

    def perform(file)
      NpcCorporationDivisionImporter.new(file).import
    end
  end
end
