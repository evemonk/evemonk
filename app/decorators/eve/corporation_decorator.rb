# frozen_string_literal: true

module Eve
  class CorporationDecorator < ApplicationDecorator
    decorates_associations :alliance, :ceo, :creator, :faction, :home_station,
      :characters, :corporation_alliance_histories, :standings,
      :loyalty_store_offers

    def date_founded
      object.date_founded&.iso8601
    end

    def description
      Rails::Html::FullSanitizer.new.sanitize(object.description)
    end

    def tax_rate
      object.tax_rate.to_s
    end
  end
end
