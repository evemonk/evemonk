# frozen_string_literal: true

module Sde
  class NpcCorporationDivisionImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load_file(file)

      entries.each_pair do |key, hash|
        division = Eve::Division.find_or_initialize_by(id: key)

        division.assign_attributes(
          description: hash["description"],
          description_full_en: hash.dig("descriptionID", "en"),
          description_full_de: hash.dig("descriptionID", "de"),
          description_full_fr: hash.dig("descriptionID", "fr"),
          description_full_ja: hash.dig("descriptionID", "ja"),
          description_full_ko: hash.dig("descriptionID", "ko"),
          description_full_ru: hash.dig("descriptionID", "ru"),
          description_full_zh: hash.dig("descriptionID", "zh"),
          internal_name: hash["internalName"],
          leader_type_name_en: hash.dig("leaderTypeNameID", "en"),
          leader_type_name_de: hash.dig("leaderTypeNameID", "de"),
          leader_type_name_fr: hash.dig("leaderTypeNameID", "fr"),
          leader_type_name_ja: hash.dig("leaderTypeNameID", "ja"),
          leader_type_name_ko: hash.dig("leaderTypeNameID", "ko"),
          leader_type_name_ru: hash.dig("leaderTypeNameID", "ru"),
          leader_type_name_zh: hash.dig("leaderTypeNameID", "zh"),
          name_en: hash.dig("nameID", "en"),
          name_de: hash.dig("nameID", "de"),
          name_fr: hash.dig("nameID", "fr"),
          name_ja: hash.dig("nameID", "ja"),
          name_ko: hash.dig("nameID", "ko"),
          name_ru: hash.dig("nameID", "ru"),
          name_zh: hash.dig("nameID", "zh")
        )

        division.save!
      end
    end
  end
end
