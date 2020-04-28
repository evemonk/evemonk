# frozen_string_literal: true

module Eve
  class FactionDecorator < ApplicationDecorator
    decorates_associations :corporation, :militia_corporation, :solar_system,
      :alliances, :standings

    def size_factor
      object.size_factor.to_s
    end

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
