# frozen_string_literal: true

module Eve
  class CharacterDecorator < ApplicationDecorator
    def birthday
      object.birthday.iso8601
    end

    def icon
      "https://imageserver.eveonline.com/Character/#{ character_id }_512.jpg"
    end

    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end

    def self.collection_decorator_class
      PaginatingDecorator
    end
  end
end
