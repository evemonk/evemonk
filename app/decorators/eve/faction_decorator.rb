# frozen_string_literal: true

module Eve
  class FactionDecorator < ApplicationDecorator
    def as_json(*)
      {
        faction_id: faction_id,
        name: name,
        description: description,
        solar_system_id: solar_system_id,
        corporation_id: corporation_id,
        militia_corporation_id: militia_corporation_id,
        size_factor: size_factor,
        station_count: station_count,
        station_system_count: station_system_count,
        is_unique: is_unique
      }
    end
  end
end
