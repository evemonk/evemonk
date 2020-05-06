# frozen_string_literal: true

class CharacterShowReflex < ApplicationReflex
  def update
    character_id = element.dataset[:id]

    CharacterImporter.new(character_id).import

    # @character = current_user.characters
    #   .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation, :current_ship_type)
    #   .find_by!(character_id: character_id)
    #   .decorate
  end
end
