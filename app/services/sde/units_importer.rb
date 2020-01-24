# frozen_string_literal: true

module Sde
  class UnitsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each do |hash|
        unit = Eve::Unit.find_or_initialize_by(unit_id: hash["unitID"])

        unit.unit_name = hash["unitName"]
        unit.description = hash["description"]
        unit.display_name = hash["displayName"]

        unit.save!
      end
    end
  end
end
