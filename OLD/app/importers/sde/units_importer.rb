# frozen_string_literal: true

module Sde
  class UnitsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load_file(file)

      entries.each do |hash|
        unit = Eve::Unit.find_or_initialize_by(id: hash["unitID"])

        unit.assign_attributes(unit_name: hash["unitName"],
          description: hash["description"],
          display_name: hash["displayName"])

        unit.save!
      end
    end
  end
end
