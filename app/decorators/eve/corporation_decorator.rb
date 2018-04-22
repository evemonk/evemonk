# frozen_string_literal: true

module Eve
  class CorporationDecorator < ApplicationDecorator
    def as_json(*)
      {
        corporation_id: corporation_id,
        name: name,
        ticker: ticker,
        member_count: member_count,
        ceo_id: ceo_id,
        alliance_id: alliance_id,
        description: description,
        tax_rate: tax_rate.to_s,
        date_founded: date_founded.iso8601,
        creator_id: creator_id,
        corporation_url: corporation_url,
        faction_id: faction_id,
        home_station_id: home_station_id,
        shares: shares
      }
    end
  end
end
