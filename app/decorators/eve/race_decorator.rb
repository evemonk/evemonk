# frozen_string_literal: true

module Eve
  class RaceDecorator < Draper::Decorator
    delegate_all

    def as_json(*)
      {
        description: description,
        race_id: race_id,
        race_name: race_name,
        short_description: short_description,
        icon_id: icon_id
      }
    end
  end
end
