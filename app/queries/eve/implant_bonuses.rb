# frozen_string_literal: true

module Eve
  class ImplantBonuses
    DOGMA_ATTRIBUTE_NAMES = [
      "perceptionBonus",
      "memoryBonus",
      "willpowerBonus",
      "intelligenceBonus",
      "charismaBonus"
    ].freeze

    attr_reader :implant

    def initialize(implant)
      @implant = implant
    end

    def implant_bonuses
      implant.type_dogma_attributes
        .where(attribute_id: attribute_ids)
        .where.not(value: 0.0)
        .map do |type_dogma_attribute|
        {name: type_dogma_attribute.dogma_attribute&.display_name,
         value: type_dogma_attribute.value}
      end
    end

    private

    def attribute_ids
      Eve::DogmaAttribute.where(name: DOGMA_ATTRIBUTE_NAMES)
        .pluck(:attribute_id)
    end
  end
end
