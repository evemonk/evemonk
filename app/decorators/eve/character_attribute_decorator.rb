# frozen_string_literal: true

module Eve
  class CharacterAttributeDecorator
    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end
  end
end
