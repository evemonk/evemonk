# frozen_string_literal: true

module Eve
  class BloodlineDecorator < ApplicationDecorator
    def as_json(*)
      {
        bloodline_id: bloodline_id,
        name: name,
        description: description,
        race_id: race_id,
        ship_type_id: ship_type_id,
        corporation_id: corporation_id,
        perception: perception,
        willpower: willpower,
        charisma: charisma,
        memory: memory,
        intelligence: intelligence
      }
    end
  end
end
