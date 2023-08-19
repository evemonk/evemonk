# frozen_string_literal: true

module Sde
  class AgentsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    # TODO: check, maybe agents needs cleanup after update
    def import
      entries = YAML.safe_load_file(file)

      entries.each_pair do |key, hash|
        eve_agent = Eve::Agent.find_or_initialize_by(id: key)

        eve_agent.assign_attributes(agent_type_id: hash["agentTypeID"],
          corporation_id: hash["corporationID"],
          division_id: hash["divisionID"],
          is_locator: hash["isLocator"],
          level: hash["level"],
          location_id: hash["locationID"],
          quality: hash["quality"])

        eve_agent.save!
      end
    end
  end
end
