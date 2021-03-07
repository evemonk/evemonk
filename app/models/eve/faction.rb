# frozen_string_literal: true

module Eve
  class Faction < Upgrow::Model
    include ImageProxy

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
