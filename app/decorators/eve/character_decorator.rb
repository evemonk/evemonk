# frozen_string_literal: true

module Eve
  class CharacterDecorator < ApplicationDecorator
    decorates_associations :alliance, :ancestry, :bloodline, :corporation,
                           :faction, :race, :character_corporation_histories

    def birthday
      object.birthday&.iso8601
    end

    def icon_tiny
      "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_32.jpg"
    end

    def icon_small
      "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_64.jpg"
    end

    def icon_medium
      "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_128.jpg"
    end

    def icon_large
      "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_256.jpg"
    end

    def icon_huge
      "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_512.jpg"
    end

    def icon_gigantic
      "#{imageproxy_url}https://imageserver.eveonline.com/Character/#{character_id}_1024.jpg"
    end

    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end

    def security_status
      object.security_status.to_s
    end
  end
end
