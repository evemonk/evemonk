# frozen_string_literal: true

module Sde
  class UnitsJob < ApplicationJob
    queue_as :default

    def perform(file)
      UnitsImporter.new(file).import
    end
  end
end
