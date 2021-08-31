# frozen_string_literal: true

module Types
  class EveCorporationType < Types::BaseObject
    description "Eve Corporation object"

    field :id, ID,
      method: :corporation_id,
      description: "Eve Corporation ID",
      null: false

    field :alliance_id, Integer,
      description: "Eve Alliance ID",
      null: true

    field :alliance, Types::EveAllianceType,
      description: "Eve Alliance",
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
      null: true

    field :home_station, Types::EveStationType,
      null: true

    field :member_count, Integer,
      null: true

    field :name, String,
      null: true

    field :shares, GraphQL::Types::BigInt,
      null: true

    field :tax_rate, Float,
      null: true

    field :ticker, String,
      null: true

    field :url, String,
      method: :corporation_url,
      null: true

    field :war_eligible, Boolean,
      null: true

    field :npc, Boolean,
      null: true

    field :characters, Types::EveCharacterType.connection_type,
      null: true

    # TODO: :corporation_alliance_histories
    # field :history
    # TODO: :standings
    # TODO: :loyalty_store_offers
    # field :loyalty_store_offers
  end
end
