# frozen_string_literal: true

module Sde
  class AgentsImporter
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def import
      entries = YAML.safe_load(File.read(file))

      entries.each do |entry|
        eve_agent = Eve::Agent.find_or_initialize_by(agent_id: entry["agentID"])

        eve_agent.assign_attributes(agent_type_id: entry["agentTypeID"],
                                    corporation_id: entry["corporationID"],
                                    division_id: entry["divisionID"],
                                    is_locator: entry["isLocator"],
                                    level: entry["level"],
                                    location_id: entry["locationID"],
                                    quality: entry["quality"])

        eve_agent.save!
      end
    end
  end
end
