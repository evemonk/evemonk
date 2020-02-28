# frozen_string_literal: true

class CharacterAgentsComponent < ActionView::Component::Base
  attr_reader :agents_standings

  def initialize(agents_standings:)
    @agents_standings = agents_standings
  end
end
