# frozen_string_literal: true

module Eve
  class FactionInput < Upgrow::Input
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

    validates :faction_id, presence: true
    validates :description, presence: true
    validates :is_unique, presence: true
    validates :name, presence: true
    validates :size_factor, presence: true
    validates :station_count, presence: true
    validates :station_system_count, presence: true
  end
end
