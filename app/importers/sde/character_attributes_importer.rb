# frozen_string_literal: true

module Sde
  class CharacterAttributesImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load_file(file)

      entries.each_pair do |key, hash|
        attribute = Eve::CharacterAttribute.find_or_initialize_by(attribute_id: key)

        attribute.assign_attributes(name_en: hash["nameID"]["en"],
          name_de: hash["nameID"]["de"],
          name_fr: hash["nameID"]["fr"],
          name_ja: hash["nameID"]["ja"],
          name_ko: hash["nameID"]["ko"],
          name_ru: hash["nameID"]["ru"],
          description: hash["description"],
          icon_id: hash["iconID"],
          notes: hash["notes"],
          short_description: hash["shortDescription"])

        attribute.save!
      end
    end
  end
end
