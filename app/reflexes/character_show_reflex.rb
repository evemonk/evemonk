# frozen_string_literal: true

class CharacterShowReflex < ApplicationReflex
  def update
    character_id = element.dataset[:id]

    CharacterImporter.new(character_id).import
    CharacterSkillsImporter.new(character_id).import
    CharacterWalletImporter.new(character_id).import
    CharacterLocationImporter.new(character_id).import
    CharacterShipImporter.new(character_id).import
    CharacterAttributesImporter.new(character_id).import
    CharacterImplantsImporter.new(character_id).import
  end
end
