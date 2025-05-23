# frozen_string_literal: true

module Types
  class EveAllianceType < Types::BaseObject
    description "Alliance object"

    field :id, ID,
      description: "Alliance ID",
      null: false

    field :name, String,
      description: "Name",
      null: true

    field :ticker, String,
      description: "Ticker",
      null: true

    # rubocop:disable GraphQL/ExtractType
    field :icon_tiny, String,
      description: "URL to tiny alliance icon",
      null: true

    field :icon_small, String,
      description: "URL to small alliance icon",
      null: true

    field :icon_medium, String,
      description: "URL to medium alliance icon",
      null: true

    field :icon_large, String,
      description: "URL to large alliance icon",
      null: true

    field :icon_huge, String,
      description: "URL to huge alliance icon",
      null: true
    # rubocop:enable GraphQL/ExtractType

    field :date_founded, GraphQL::Types::ISO8601DateTime,
      description: "Date founded",
      null: true

    field :creator_corporation_id, Integer,
      description: "Creator Corporation ID (Corporation ID)",
      null: true

    field :creator_corporation, Types::EveCorporationType,
      description: "Creator Corporation (Corporation)",
      null: true

    field :creator_id, Integer,
      description: "Creator ID (Character ID)",
      null: true

    field :creator, Types::EveCharacterType,
      description: "Creator (Character)",
      null: true

    field :executor_corporation_id, Integer,
      description: "Executor Corporation ID (Corporation ID)",
      null: true

    field :executor_corporation, Types::EveCorporationType,
      description: "Executor Corporation (Corporation)",
      null: true

    field :faction_id, Integer,
      description: "Faction ID",
      null: true

    field :faction, Types::EveFactionType,
      description: "Faction",
      null: true

    field :corporations_count, Integer,
      description: "Corporations count",
      null: true

    field :characters_count, Integer,
      description: "Characters count",
      null: true

    field :corporations, Types::EveCorporationType.connection_type,
      description: "Corporations collection",
      null: true

    field :characters, Types::EveCharacterType.connection_type,
      description: "Characters collection",
      null: true

    # TODO: corporation_alliance_histories
    # field :history, [Types::AllianceHistoryType], null: true
  end
end
