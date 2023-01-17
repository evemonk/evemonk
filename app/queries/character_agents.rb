# frozen_string_literal: true

class CharacterAgents
  attr_reader :character, :division_id

  def initialize(character, division_id)
    @character = character
    @division_id = division_id
  end

  def query
    return @character_agents if @character_agents

    @character_agents = character.standings.agents.includes(agent: :division)

    return @character_agents if division_id.blank? || division_id == "-1"

    @character_agents = @character_agents.where(eve_agents: { division_id: division_id })
  end
end
