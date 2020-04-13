# frozen_string_literal: true

module Sde
  class BlueprintsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each_pair do |key, hash|
        eve_blueprint = Eve::Blueprint.find_or_initialize_by(type_id: key)

        copying_time = hash.dig("activities", "copying", "time")
        # manufacturing_time = hash.dig("activities", "manufacturing", "time")
        # research_material_time = hash.dig("activities", "research_material", "time")
        # research_time_time = hash.dig("activities", "research_time", "time")
        # invention_time = hash.dig("activities", "invention", "time")

        eve_blueprint.transaction do
          # import_more_information(eve_blueprint, hash)

          eve_blueprint.assign_attributes(copying_time: copying_time,
                                          # manufacturing_time: manufacturing_time,
                                          # research_material_time: research_material_time,
                                          # research_time_time: research_time_time,
                                          # invention_time: invention_time,
                                          # max_production_limit: hash["maxProductionLimit"],
                                          is_blueprint: true)

          eve_blueprint.save!
        end
      end
    end

    private

    def import_more_information(eve_blueprint, hash)
      # import_blueprint_invention_materials(eve_blueprint, hash)
      #
      # import_blueprint_invention_products(eve_blueprint, hash)
      #
      # import_blueprint_invention_skills(eve_blueprint, hash)
      #
      # import_blueprint_manufacturing_materials(eve_blueprint, hash)
      #
      # import_blueprint_manufacturing_products(eve_blueprint, hash)
      #
      # import_blueprint_manufacturing_skills(eve_blueprint, hash)
    end

    # def import_blueprint_invention_materials(eve_blueprint, hash)
    #   eve_blueprint.blueprint_invention_materials.destroy_all
    #
    #   invention_materials = hash.dig("activities", "invention", "materials")
    #
    #   invention_materials&.each do |invention_material|
    #     Eve::BlueprintInventionMaterial.create!(blueprint_id: eve_blueprint.type_id,
    #                                             quantity: invention_material["quantity"],
    #                                             type_id: invention_material["typeID"])
    #   end
    # end
    #
    # def import_blueprint_invention_products(eve_blueprint, hash)
    #   eve_blueprint.blueprint_invention_products.destroy_all
    #
    #   invention_products = hash.dig("activities", "invention", "products")
    #
    #   invention_products&.each do |invention_product|
    #     Eve::BlueprintInventionProduct.create!(blueprint_id: eve_blueprint.type_id,
    #                                            probability: invention_product["probability"],
    #                                            quantity: invention_product["quantity"],
    #                                            type_id: invention_product["typeID"])
    #   end
    # end
    #
    # def import_blueprint_invention_skills(eve_blueprint, hash)
    #   eve_blueprint.blueprint_invention_skills.destroy_all
    #
    #   invention_skills = hash.dig("activities", "invention", "skills")
    #
    #   invention_skills&.each do |invention_skill|
    #     Eve::BlueprintInventionSkill.create!(blueprint_id: eve_blueprint.type_id,
    #                                          level: invention_skill["level"],
    #                                          type_id: invention_skill["typeID"])
    #   end
    # end
    #
    # def import_blueprint_manufacturing_materials(eve_blueprint, hash)
    #   eve_blueprint.blueprint_manufacturing_materials.destroy_all
    #
    #   manufacturing_materials = hash.dig("activities", "manufacturing", "materials")
    #
    #   manufacturing_materials&.each do |manufacturing_material|
    #     Eve::BlueprintManufacturingMaterial.create!(blueprint_id: eve_blueprint.type_id,
    #                                                 quantity: manufacturing_material["quantity"],
    #                                                 type_id: manufacturing_material["typeID"])
    #   end
    # end
    #
    # def import_blueprint_manufacturing_products(eve_blueprint, hash)
    #   eve_blueprint.blueprint_manufacturing_products.destroy_all
    #
    #   manufacturing_products = hash.dig("activities", "manufacturing", "products")
    #
    #   manufacturing_products&.each do |manufacturing_product|
    #     Eve::BlueprintManufacturingProduct.create!(blueprint_id: eve_blueprint.type_id,
    #                                                quantity: manufacturing_product["quantity"],
    #                                                type_id: manufacturing_product["typeID"])
    #   end
    # end
    #
    # def import_blueprint_manufacturing_skills(eve_blueprint, hash)
    #   eve_blueprint.blueprint_manufacturing_skills.destroy_all
    #
    #   manufacturing_skills = hash.dig("activities", "manufacturing", "skills")
    #
    #   manufacturing_skills&.each do |manufacturing_skill|
    #     Eve::BlueprintManufacturingSkill.create!(blueprint_id: eve_blueprint.type_id,
    #                                              level: manufacturing_skill["level"],
    #                                              type_id: manufacturing_skill["typeID"])
    #   end
    # end
  end
end
