# frozen_string_literal: true

module Types
  class EveCorporationType < Types::BaseObject
    description "Corporation object"

    field :id, ID,
      method: :corporation_id,
      description: "Corporation ID",
      null: false

    field :icon, EveCorporationIconType,
      description: "Eve Corporation Icons",
      method: :itself,
      null: true

    field :alliance_id, Integer,
      description: "Alliance ID",
      null: true

    field :alliance, Types::EveAllianceType,
      description: "Alliance",
      null: true

    field :ceo_id, Integer,
      description: "CEO ID (Character ID)",
      null: true

    field :ceo, Types::EveCharacterType,
      description: "CEO (Character)",
      null: true

    field :creator_id, Integer,
      description: "Creator ID (Character ID)",
      null: true

    field :creator, Types::EveCharacterType,
      description: "Creator (Character)",
      null: true

    field :date_founded, GraphQL::Types::ISO8601DateTime,
      description: "Date founded",
      null: true

    field :description, String,
      method: :sanitized_description,
      description: "Description",
      null: true

    field :faction_id, Integer,
      description: "Faction ID",
      null: true

    field :faction, Types::EveFactionType,
      description: "Faction",
      null: true

    field :home_station_id, Integer,
      description: "Home station ID (Station ID)",
      null: true

    field :home_station, Types::EveStationType,
      description: "Home station (Station)",
      null: true

    field :member_count, Integer,
      description: "Member count",
      null: true

    field :name, String,
      description: "Name",
      null: true

    field :shares, GraphQL::Types::BigInt,
      description: "Shares",
      null: true

    field :tax_rate, Float,
      description: "Tax rate",
      null: true

    field :ticker, String,
      description: "Ticker",
      null: true

    field :url, String,
      method: :corporation_url,
      description: "URL",
      null: true

    field :war_eligible, Boolean,
      description: "War eligible",
      null: true

    field :npc, Boolean,
      description: "NPC",
      null: true

    field :characters, Types::EveCharacterType.connection_type,
      description: "Characters collection",
      null: true

    # TODO: :corporation_alliance_histories
    # field :history
    # TODO: :standings
    # TODO: :loyalty_store_offers
    # field :loyalty_store_offers
  end
end
