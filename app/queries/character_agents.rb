# frozen_string_literal: true

class CharacterAgents
  attr_reader :character, :filter

  def initialize(character, filter)
    @character = character
    @filter = filter
  end

  def query
    character.agents_standings.includes(standingable: :division)
  end
end
