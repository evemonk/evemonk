# frozen_string_literal: true

module Eve
  class CharacterAttributeDecorator < ApplicationDecorator
    decorates_associations :icon

    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end
  end
end
