# frozen_string_literal: true

module Sde
  class BlueprintsManufacturingProductsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load_file(file)

      entries.each_pair do |key, hash|
        eve_blueprint = Eve::Blueprint.find_by!(type_id: key)

        eve_blueprint.transaction do
          eve_blueprint.blueprint_manufacturing_products.destroy_all

          manufacturing_products = hash.dig("activities", "manufacturing", "products")

          manufacturing_products&.each do |manufacturing_product|
            type_id = manufacturing_product["typeID"]

            Eve::BlueprintManufacturingProduct.create!(blueprint_id: eve_blueprint.type_id,
              quantity: manufacturing_product["quantity"],
              type_id: type_id)

            eve_type = Eve::Type.find_or_initialize_by(type_id: type_id)

            eve_type.update!(is_manufacturing_item: true)
          end

          eve_blueprint.save!
        end
      end
    end
  end
end
