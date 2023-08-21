# frozen_string_literal: true

module Sde
  class BlueprintsInventionSkillsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load_file(file)

      entries.each_pair do |key, hash|
        eve_blueprint = Eve::Blueprint.find_by!(type_id: key)

        eve_blueprint.transaction do
          eve_blueprint.blueprint_invention_skills.destroy_all

          invention_skills = hash.dig("activities", "invention", "skills")

          invention_skills&.each do |invention_skill|
            Eve::BlueprintInventionSkill.create!(blueprint_id: eve_blueprint.type_id,
              level: invention_skill["level"],
              type_id: invention_skill["typeID"])
          end

          eve_blueprint.save!
        end
      end
    end
  end
end
