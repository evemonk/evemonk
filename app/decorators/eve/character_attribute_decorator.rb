# frozen_string_literal: true

module Eve
  class CharacterAttributeDecorator < ApplicationDecorator
    def icon_url
      case object.attribute_name
      when "Charisma"
        "Icons/items/22_32_1.png"
      when "Intelligence"
        "Icons/items/"
      when "Perception"
        "Icons/items/"
      when "Memory"
        "Icons/items/"
      when "Willpower"
        "Icons/items/"
      else
        raise "Unknown attribute name for Eve::CharacterAttribute"
      end
    end

    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end
  end
end
