# frozen_string_literal: true

module Eve
  class FactionDecorator < ApplicationDecorator
    decorates_associations :alliances, :corporation, :solar_system

    def size_factor
      object.size_factor.to_s
    end

    def icon_tiny
      "#{imageproxy_url}https://imageserver.eveonline.com/Alliance/#{faction_id}_32.png"
    end

    def icon_small
      "#{imageproxy_url}https://imageserver.eveonline.com/Alliance/#{faction_id}_64.png"
    end

    def icon_medium
      "#{imageproxy_url}https://imageserver.eveonline.com/Alliance/#{faction_id}_128.png"
    end
  end
end
