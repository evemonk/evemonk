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
        manufacturing_time = hash.dig("activities", "manufacturing", "time")
        research_material_time = hash.dig("activities", "research_material", "time")
        research_time_time = hash.dig("activities", "research_time", "time")
        invention_time = hash.dig("activities", "invention", "time")

        eve_blueprint.transaction do
          import_more_information(eve_blueprint, hash)

          eve_blueprint.assign_attributes(copying_time: copying_time,
                                          manufacturing_time: manufacturing_time,
                                          research_material_time: research_material_time,
                                          research_time_time: research_time_time,
                                          invention_time: invention_time,
                                          max_production_limit: hash["maxProductionLimit"],
                                          is_blueprint: true)

          eve_blueprint.save!
        end
      end
    end

    private

    def import_more_information(eve_blueprint, hash)
      import_blueprint_manufacturing_skills(eve_blueprint, hash)
    end

    def import_blueprint_manufacturing_skills(eve_blueprint, hash)
    #   eve_blueprint.blueprint_manufacturing_skills.destroy_all
    #
    #   manufacturing_skills = hash.dig("activities", "manufacturing", "skills")
    #
    #   manufacturing_skills&.each do |manufacturing_skill|
    #     Eve::BlueprintManufacturingSkill.create!(blueprint_id: eve_blueprint.type_id,
    #                                              level: manufacturing_skill["level"],
    #                                              type_id: manufacturing_skill["typeID"])
    #   end
    end
  end
end
