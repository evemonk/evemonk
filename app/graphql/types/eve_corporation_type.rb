# frozen_string_literal: true

module Types
  class EveCorporationType < Types::BaseObject
    description "Eve Corporation object"

    field :id, ID,
      method: :corporation_id,
      null: false

    field :alliance_id, Integer,
      null: true

    field :alliance, Types::EveAllianceType,
      null: true

    field :ceo_id, Integer,
      null: true

    field :ceo, Types::EveCharacterType,
      null: true

    field :creator_id, Integer,
      null: true

    field :creator, Types::EveCharacterType,
      null: true

    field :date_founded, GraphQL::Types::ISO8601DateTime,
      null: true

    field :description, String,
      method: :sanitized_description,
      null: true

    field :faction_id, Integer,
      null: true

    field :faction, Types::EveFactionType,
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
