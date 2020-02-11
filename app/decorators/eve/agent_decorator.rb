# frozen_string_literal: true

module Eve
  class AgentDecorator < ApplicationDecorator
    decorates_associations :standings

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=32&tenant=tranquility"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=64&tenant=tranquility"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=128&tenant=tranquility"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=256&tenant=tranquility"
    end

    def icon_huge
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=512&tenant=tranquility"
    end

    def icon_gigantic
      "#{imageproxy_url}https://images.evetech.net/characters/#{agent_id}/portrait?size=1024&tenant=tranquility"
    end
  end
end
