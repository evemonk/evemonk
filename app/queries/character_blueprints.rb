# frozen_string_literal: true

class CharacterBlueprints
  attr_reader :character, :filter

  def initialize(character, filter)
    @character = character
    @filter = filter
  end

  def query
    return @character_blueprints if @character_blueprints

    @character_blueprints = character.character_blueprints
      .joins(blueprint: :group)
      .order("eve_types.name_en": :asc)

    return @character_blueprints if filter.blank?

    @character_blueprints =
      case filter
      when "0" # All
        @character_blueprints
      when "1" # BPO
        @character_blueprints.where(quantity: -1)
      when "2" # BPC
        @character_blueprints.where(quantity: -2)
      when "3" # Ancient Relics
        @character_blueprints.where(eve_types: {eve_groups: {category_id: Eve::Categories::ANCIENT_RELICS_ID}})
      when "4" # Stacked
        @character_blueprints.where(quantity: [0..])
      else
        @character_blueprints
      end
  end
end
