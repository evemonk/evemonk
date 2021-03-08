# frozen_string_literal: true

module Eve
  class Corporation < Upgrow::Model
    include ActionView::Helpers::NumberHelper
    include ImageProxy

    attribute :corporation_id
    attribute :alliance_id
    attribute :ceo_id
    attribute :creator_id
    attribute :date_founded
    attribute :description
    attribute :faction_id
    attribute :home_station_id
    attribute :member_count
    attribute :name
    attribute :shares
    attribute :tax_rate
    attribute :ticker
    attribute :corporation_url
    attribute :war_eligible
    attribute :npc

    def icon_tiny
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=32"
    end

    def icon_small
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=64"
    end

    def icon_medium
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=128"
    end

    def icon_large
      "#{imageproxy_url}https://images.evetech.net/corporations/#{corporation_id}/logo?size=256"
    end

    def formatted_member_count
      number_with_delimiter(member_count, delimiter: ",")
    end

    def sanitized_description
      Rails::Html::FullSanitizer.new.sanitize(description)
    end
  end
end
