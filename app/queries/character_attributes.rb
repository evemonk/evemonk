class CharacterAttributes
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def total_perception
    character.perception.to_i + perception_bonus.to_i
  end

  def perception_bonus
    @perception_bonus ||= bonus_value("perceptionBonus")
  end

  def total_memory
    character.memory.to_i + memory_bonus.to_i
  end

  def memory_bonus
    @memory_bonus ||= bonus_value("memoryBonus")
  end

  def total_willpower
    character.willpower.to_i + willpower_bonus.to_i
  end

  def willpower_bonus
    @willpower_bonus ||= bonus_value("willpowerBonus")
  end

  def total_intelligence
    character.intelligence.to_i + intelligence_bonus.to_i
  end

  def intelligence_bonus
    @intelligence_bonus ||= bonus_value("intelligenceBonus")
  end

  def total_charisma
    character.charisma.to_i + charisma_bonus.to_i
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
