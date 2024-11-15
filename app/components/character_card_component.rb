# frozen_string_literal: true

class CharacterCardComponent < ApplicationComponent
  # @param character [Character]
  # @param full [Boolean] Optional. Show full profile. Default: false
  def initialize(character:, full: false)
    @character = character
    @full = full
  end
end
