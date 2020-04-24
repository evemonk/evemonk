# frozen_string_literal: true

module Sde
  class BlueprintsInventionProductsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each_pair do |key, hash|
        eve_blueprint = Eve::Blueprint.find_or_initialize_by(type_id: key)

        eve_blueprint.transaction do
          eve_blueprint.blueprint_invention_products.destroy_all

          invention_products = hash.dig("activities", "invention", "products")

          invention_products&.each do |invention_product|
            type_id = invention_product["typeID"]

            Eve::BlueprintInventionProduct.create!(blueprint_id: eve_blueprint.type_id,
                                                   probability: invention_product["probability"],
                                                   quantity: invention_product["quantity"],
                                                   type_id: type_id)

            Eve::Type.find_or_initialize_by(type_id: type_id).update!(is_manufacturing_item: true)
          end

          eve_blueprint.save!
        end
      end
    end
  end
end
