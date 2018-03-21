# frozen_string_literal: true

module Eve
  class Faction < ApplicationRecord
    validates :faction_id, presence: true

    validates :faction_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :name, presence: true

    validates :description, presence: true

    validates :solar_system_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :corporation_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :militia_corporation_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :size_factor, presence: true

    validates :station_count, presence: true

    validates :station_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :station_system_count, presence: true

    validates :station_system_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
