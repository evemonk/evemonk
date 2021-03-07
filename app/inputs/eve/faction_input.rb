# frozen_string_literal: true

module Eve
  class FactionInput < Upgrow::Input
    attribute :faction_id
    attribute :corporation_id
    attribute :description_en
    attribute :description_de
    attribute :description_fr
    attribute :description_ja
    attribute :description_ru
    attribute :description_ko
    attribute :is_unique
    attribute :militia_corporation_id
    attribute :name_en
    attribute :name_de
    attribute :name_fr
    attribute :name_ja
    attribute :name_ru
    attribute :name_ko
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
