# frozen_string_literal: true

module Eve
  class RaceDecorator < ApplicationDecorator
    def as_json(*)
      {
        description: description,
        race_id: race_id,
        name: name,
        alliance_id: alliance_id
      }
    end
  end
end
