# frozen_string_literal: true

class CharacterInfoReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def update
    @character = current_user.characters
      .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation, :current_ship_type)
      .find_by!(character_id: element.dataset[:id])
      .decorate

    CharacterWalletImporter.new(@character.character_id).import
  end
end
