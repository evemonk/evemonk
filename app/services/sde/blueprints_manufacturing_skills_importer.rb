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
      end
    end
  end
end
