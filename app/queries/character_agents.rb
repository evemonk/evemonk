# frozen_string_literal: true

class CharacterAgents
  attr_reader :character, :filter

  def initialize(character, filter)
    @character = character
    @filter = filter
  end

  def query
    return @character_agents if @character_agents

    @character_agents = character.standings.agents.includes(agent: :division)

    return @character_agents if filter.blank?

    @character_agents =
      case filter
      when "-1" # All divisions
        @character_agents
      else
        @character_agents.where(eve_agents: { division_id: filter })
      end
  end
end
