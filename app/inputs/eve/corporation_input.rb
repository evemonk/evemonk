# frozen_string_literal: true

module Eve
  class CorporationInput < Upgrow::Input
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

    validates :corporation_id, presence: true
    validates :ceo_id, presence: true
    validates :creator_id, presence: true
    validates :member_count, presence: true
    validates :name, presence: true
    validates :tax_rate, presence: true
    validates :ticker, presence: true
  end
end
