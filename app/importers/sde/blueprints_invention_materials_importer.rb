# frozen_string_literal: true

module Sde
  class BlueprintsInventionMaterialsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each_pair do |key, hash|
        eve_blueprint = Eve::Blueprint.find(key)

        eve_blueprint.transaction do
          eve_blueprint.blueprint_invention_materials.destroy_all

          invention_materials = hash.dig("activities", "invention", "materials")

          invention_materials&.each do |invention_material|
            Eve::BlueprintInventionMaterial.create!(blueprint: eve_blueprint,
              quantity: invention_material["quantity"],
              type_id: invention_material["typeID"])
          end

          eve_blueprint.save!
        end
      end
    end
  end
end
