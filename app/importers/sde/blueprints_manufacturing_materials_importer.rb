# frozen_string_literal: true

module Sde
  class BlueprintsManufacturingMaterialsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load_file(file)

      entries.each_pair do |key, hash|
        eve_blueprint = Eve::Blueprint.find_by!(type_id: key)

        eve_blueprint.transaction do
          eve_blueprint.blueprint_manufacturing_materials.destroy_all

          manufacturing_materials = hash.dig("activities", "manufacturing", "materials")

          manufacturing_materials&.each do |manufacturing_material|
            Eve::BlueprintManufacturingMaterial.create!(blueprint_id: eve_blueprint.type_id,
              quantity: manufacturing_material["quantity"],
              type_id: manufacturing_material["typeID"])
          end

          eve_blueprint.save!
        end
      end
    end
  end
end
