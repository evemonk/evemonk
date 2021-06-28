# frozen_string_literal: true

class CharacterAttributes
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def perception_without_bonuses
    character.perception.to_i - perception_bonus.to_i
  end

  def perception_bonus
    @perception_bonus ||= bonus_value("perceptionBonus")
  end

  def memory_without_bonuses
    character.memory.to_i - memory_bonus.to_i
  end

  def memory_bonus
    @memory_bonus ||= bonus_value("memoryBonus")
  end

  def willpower_without_bonuses
    character.willpower.to_i - willpower_bonus.to_i
  end

  def willpower_bonus
    @willpower_bonus ||= bonus_value("willpowerBonus")
  end

  def intelligence_without_bonuses
    character.intelligence.to_i - intelligence_bonus.to_i
  end

  def intelligence_bonus
    @intelligence_bonus ||= bonus_value("intelligenceBonus")
  end

  def charisma_without_bonuses
    character.charisma.to_i - charisma_bonus.to_i
  end

  def charisma_bonus
    @charisma_bonus ||= bonus_value("charismaBonus")
  end

  private

  def bonus_value(bonus_name)
    dogma_attribute = Eve::DogmaAttribute.find_by!(name: bonus_name)

    Eve::TypeDogmaAttribute.where(attribute_id: dogma_attribute.attribute_id,
      type_id: character.implant_ids).sum(:value)
  end
end
