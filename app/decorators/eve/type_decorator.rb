# frozen_string_literal: true

module Eve
  class TypeDecorator < ApplicationDecorator
    decorates_associations :graphic, :group, :icon, # :market_group,
      :type_dogma_attributes, :type_dogma_effects

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/icon?size=32&tenant=tranquility"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/icon?size=64&tenant=tranquility"
    end

    def render_tiny
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=32&tenant=tranquility"
    end

    def render_small
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=64&tenant=tranquility"
    end

    def render_medium
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=128&tenant=tranquility"
    end

    def render_large
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=256&tenant=tranquility"
    end

    def render_huge
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=512&tenant=tranquility"
    end
  end
end
