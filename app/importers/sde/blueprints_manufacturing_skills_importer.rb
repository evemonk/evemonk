# frozen_string_literal: true

module Sde
  class BlueprintsManufacturingSkillsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each_pair do |key, hash|
        eve_blueprint = Eve::Blueprint.find(key)

        eve_blueprint.transaction do
          eve_blueprint.blueprint_manufacturing_skills.destroy_all

          manufacturing_skills = hash.dig("activities", "manufacturing", "skills")

          manufacturing_skills&.each do |manufacturing_skill|
            Eve::BlueprintManufacturingSkill.create!(blueprint: eve_blueprint,
              level: manufacturing_skill["level"],
              type_id: manufacturing_skill["typeID"])
          end

          eve_blueprint.save!
        end
      end
    end
  end
end
