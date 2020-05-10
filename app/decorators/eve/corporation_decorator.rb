# frozen_string_literal: true

module Eve
  class CorporationDecorator < ApplicationDecorator
    include ActionView::Helpers::NumberHelper

    decorates_associations :alliance, :ceo, :creator, :faction, :home_station,
      :characters, :corporation_alliance_histories, :standings,
      :loyalty_store_offers

    def date_founded
      object.date_founded&.iso8601
    end

    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end

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

    def tax_rate
      object.tax_rate.to_s
    end

    def formatted_member_count
      number_with_delimiter(member_count, delimiter: ",")
    end
  end
end
