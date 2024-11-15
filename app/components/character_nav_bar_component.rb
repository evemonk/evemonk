# frozen_string_literal: true

class CharacterNavBarComponent < ApplicationComponent
  # @param character [Character]
  # @param current_page [String, Symbol]
  def initialize(character:, current_page:)
    @character = character
    @current_page = current_page.to_sym
  end
end
