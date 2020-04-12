# frozen_string_literal: true

module Eve
  class TypeDecorator < ApplicationDecorator
    # include ActionView::Helpers::TextHelper
    include ActionView::Helpers::NumberHelper

    # TODO: add :dogma_effects
    decorates_associations :graphic, :group, :icon, :market_group,
      :type_dogma_attributes, :dogma_attributes, :type_dogma_effects

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/icon?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/icon?size=64"
    end

    def render_tiny
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=32"
    end

    def render_small
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=64"
    end

    def render_medium
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=128"
    end

    def render_large
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=256"
    end

    def render_huge
      "#{imageproxy_url}https://images.evetech.net/types/#{type_id}/render?size=512"
    end

    def average_price_formatted
      number_with_delimiter(object.average_price.to_i, delimiter: " ")
    end

    # def simple_description
    #   # simple_format(SafeEveSanitizer.new.sanitize(description))
    #   SafeEveSanitizer.new.sanitize(description)
    # end
    #
    # def skill_level
    #   case object.trained_skill_level
    #   when 1
    #     "I"
    #   when 2
    #     "II"
    #   when 3
    #     "III"
    #   when 4
    #     "IV"
    #   when 5
    #     "V"
    #   else
    #     raise "Unsupported trained skill level"
    #   end
    # end
  end
end
