# frozen_string_literal: true

module Eve
  class Faction < Upgrow::Model
    include ImageProxy

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

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/corporations/#{faction_id}/logo?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/corporations/#{faction_id}/logo?size=64"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/corporations/#{faction_id}/logo?size=128"
    end
  end
end
