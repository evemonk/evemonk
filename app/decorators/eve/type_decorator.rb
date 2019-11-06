# frozen_string_literal: true

module Eve
  class TypeDecorator < ApplicationDecorator
    decorates_associations :graphic, :icon, :type_dogma_attributes,
      :type_dogma_effects

    def icon_tiny
      "#{imageproxy_url}https://imageserver.eveonline.com/Type/#{type_id}_32.png"
    end

    def icon_small
      "#{imageproxy_url}https://imageserver.eveonline.com/Type/#{type_id}_64.png"
    end
  end
end
