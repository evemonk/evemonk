# frozen_string_literal: true

module Sde
  class CertificatesImporter
    LEVELS = {"basic" => 1,
              "standard" => 2,
              "improved" => 3,
              "advanced" => 4,
              "elite" => 5}.freeze

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each_pair do |key, hash|
        eve_certificate = Eve::Certificate.find_or_initialize_by(id: key)

        eve_certificate.assign_attributes(description: hash["description"],
          group_id: hash["groupID"],
          name: hash["name"])

        eve_certificate.certificate_recommended_types.destroy_all

        hash["recommendedFor"]&.each do |recommended_type_id|
          eve_certificate.certificate_recommended_types.build(type_id: recommended_type_id)
        end

        eve_certificate.certificate_skills.destroy_all

        hash["skillTypes"]&.each_pair do |skill_id, skill_hash|
          skill_hash.each do |level, value|
            eve_certificate.certificate_skills.build(skill_id: skill_id,
              level: LEVELS.fetch(level),
              skill_level: value)
          end
        end

        eve_certificate.save!
      end
    end
  end
end
