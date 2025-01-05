# frozen_string_literal: true

module Sde
  class BlueprintsJob < ApplicationJob
    queue_as :default

    def perform(file)
      BlueprintsImporter.new(file).import

      BlueprintsInventionMaterialsImporter.new(file).import

      BlueprintsInventionProductsImporter.new(file).import

      BlueprintsInventionSkillsImporter.new(file).import

      BlueprintsManufacturingMaterialsImporter.new(file).import

      BlueprintsManufacturingProductsImporter.new(file).import

      BlueprintsManufacturingSkillsImporter.new(file).import
    end
  end
end
