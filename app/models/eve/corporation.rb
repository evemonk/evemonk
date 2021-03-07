# frozen_string_literal: true

module Eve
  class Corporation < Upgrow::Model
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
  end
end
