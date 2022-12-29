# frozen_string_literal: true

module Eve
  class CharacterAttribute < ApplicationRecord
    extend Mobility

    has_paper_trail

    translates :name

    belongs_to :icon, optional: true

    def sanitized_description
      Rails::Html::FullSanitizer.new.sanitize(description)
    end
  end
end
