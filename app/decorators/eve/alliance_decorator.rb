# frozen_string_literal: true

module Eve
  class AllianceDecorator < ApplicationDecorator
    decorates_associations :creator_corporation, :creator,
                           :executor_corporation, :faction,
                           :corporations, :characters

    def date_founded
      object.date_founded.iso8601
    end

    def icon
      "https://imageserver.eveonline.com/Alliance/#{alliance_id}_128.png"
    end
  end
end
