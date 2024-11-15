# frozen_string_literal: true

class CharacterCardComponent < ApplicationComponent
  # @param character [Character]
  # @param full [Boolean] Show full profile
  def initialize(character:, full:)
    @character = character
    @full = full
  end
end
