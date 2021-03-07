# frozen_string_literal: true

module Eve
  class Faction < Upgrow::Model
    attribute :faction_id
    attribute :corporation_id
    attribute :description
    attribute :is_unique
    attribute :militia_corporation_id
    attribute :name
    attribute :size_factor
    attribute :solar_system_id
    attribute :station_count
    attribute :station_system_count
  end
end
