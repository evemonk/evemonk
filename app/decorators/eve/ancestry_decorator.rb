# frozen_string_literal: true

module Eve
  class AncestryDecorator < ApplicationDecorator
    def as_json(*)
      {
        ancestry_id: ancestry_id,
        name: name,
        bloodline_id: bloodline_id,
        description: description,
        short_description: short_description,
        icon_id: icon_id
      }
    end
  end
end
