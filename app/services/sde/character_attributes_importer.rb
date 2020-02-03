# frozen_string_literal: true

module Sde
  class CharacterAttributesImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each do |entry|
        attribute = Eve::CharacterAttribute.find_or_initialize_by(attribute_id: entry["attributeID"])

        attribute.assign_attributes(attribute_name: entry["attributeName"],
                                    description: entry["description"],
                                    icon_id: entry["iconID"],
                                    notes: entry["notes"],
                                    short_description: entry["shortDescription"])

        attribute.save!
      end
    end
  end
end
