# frozen_string_literal: true

# SDE = Sde

module Sde
  class CharacterAttributes
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      yaml = YAML.safe_load(File.read(file))

      yaml.each do |entry|
        character_attribute = Eve::CharacterAttribute.find_or_initialize_by(attribute_id: entry["attributeID"])

        character_attribute.attribute_name = entry["attributeName"]
        character_attribute.description = entry["description"]
        character_attribute.icon_id = entry["iconID"]
        character_attribute.notes = entry["notes"]
        character_attribute.short_description = entry["shortDescription"]

        character_attribute.save!
      end
    end
  end
end
