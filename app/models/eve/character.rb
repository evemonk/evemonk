# frozen_string_literal: true

module Eve
  class Character < Upgrow::Model
    include ImageProxy

    attribute :character_id
    attribute :alliance_id
    attribute :ancestry_id
    attribute :birthday
    attribute :bloodline_id
    attribute :corporation_id
    attribute :description
    attribute :faction_id
    attribute :gender
    attribute :name
    attribute :race_id
    attribute :security_status
    attribute :title

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=64"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=128"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=256"
    end

    def icon_huge
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=512"
    end

    def icon_gigantic
      "#{imageproxy_url}https://images.evetech.net/characters/#{character_id}/portrait?size=1024"
    end

    def sanitized_description
      Rails::Html::FullSanitizer.new.sanitize(description)
    end

    def rounded_security_status
      security_status&.round(1)
    end
  end
end
