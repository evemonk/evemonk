# frozen_string_literal: true

module Eve
  class AgentDecorator < ApplicationDecorator
    decorates_associations :location, :corporation, :standings

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=64"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=128"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=256"
    end

    def icon_huge
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=512"
    end

    def icon_gigantic
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=1024"
    end
  end
end
