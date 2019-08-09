# frozen_string_literal: true

module Eve
  class AllianceDecorator < ApplicationDecorator
    decorates_associations :creator_corporation, :creator,
                           :executor_corporation, :faction,
                           :corporations, :characters

    def date_founded
      object.date_founded.iso8601
    end

    def icon_tiny
      "#{imageproxy_url}https://imageserver.eveonline.com/Alliance/#{alliance_id}_32.png"
    end

    def icon_small
      "#{imageproxy_url}https://imageserver.eveonline.com/Alliance/#{alliance_id}_64.png"
    end

    def icon_medium
      "#{imageproxy_url}https://imageserver.eveonline.com/Alliance/#{alliance_id}_128.png"
    end
  end
end
