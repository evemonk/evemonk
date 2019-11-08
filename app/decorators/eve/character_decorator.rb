# frozen_string_literal: true

module Eve
  class CharacterDecorator < ApplicationDecorator
    decorates_associations :alliance, :ancestry, :bloodline, :corporation,
      :faction, :race, :character_corporation_histories

    def birthday
      object.birthday&.iso8601
    end

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=32&tenant=tranquility"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=64&tenant=tranquility"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=128&tenant=tranquility"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=256&tenant=tranquility"
    end

    def icon_huge
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=512&tenant=tranquility"
    end

    def icon_gigantic
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=1024&tenant=tranquility"
    end

    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end

    def security_status
      object.security_status.to_s
    end
  end
end
