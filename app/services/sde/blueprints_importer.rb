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
        eve_type = Eve::Type.find_or_initialize_by(type_id: key)

        copying_time = hash.fetch("activities", {}).fetch("copying", {}).fetch("time", nil)
        manufacturing_time = hash.fetch("activities", {}).fetch("manufacturing", {}).fetch("time", nil)
        research_material_time = hash.fetch("activities", {}).fetch("research_material", {}).fetch("time", nil)
        research_time_time = hash.fetch("activities", {}).fetch("research_time", {}).fetch("time", nil)
        invention_time = hash.fetch("activities", {}).fetch("invention", {}).fetch("time", nil)

        eve_type.assign_attributes(copying_time: copying_time,
                                   manufacturing_time: manufacturing_time,
                                   research_material_time: research_material_time,
                                   research_time_time: research_time_time,
                                   invention_time: invention_time,
                                   max_production_limit: hash["maxProductionLimit"])

        eve_type.save!
      end
    end
  end
end
