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
        eve_type = Eve::Type.find_or_initialize_by(id: key)

        copying_time = hash.dig("activities", "copying", "time")
        manufacturing_time = hash.dig("activities", "manufacturing", "time")
        research_material_time = hash.dig("activities", "research_material", "time")
        research_time_time = hash.dig("activities", "research_time", "time")
        invention_time = hash.dig("activities", "invention", "time")

        eve_type.transaction do
          eve_type.assign_attributes(copying_time: copying_time,
            manufacturing_time: manufacturing_time,
            research_material_time: research_material_time,
            research_time_time: research_time_time,
            invention_time: invention_time,
            max_production_limit: hash["maxProductionLimit"],
            is_blueprint: true)

          eve_type.save!
        end
      end
    end
  end
end
