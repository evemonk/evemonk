# frozen_string_literal: true

module Types
  class EveAllianceType < Types::BaseObject
    description "Eve Alliance object"

    field :id, ID,
      description: "Eve Alliance ID",
      null: false

    field :name, String,
      description: "Eve Alliance name",
      null: true

    field :ticker, String,
      description: "Eve Alliance ticker",
      null: true

    field :date_founded, GraphQL::Types::ISO8601DateTime,
      null: true

    field :creator_corporation_id, Integer,
      null: true

    field :creator_corporation, Types::EveCorporationType,
      null: true

    field :creator_id, Integer,
      null: true

    field :creator, Types::EveCharacterType,
      null: true

    field :executor_corporation_id, Integer,
      null: true

    field :executor_corporation, Types::EveCorporationType,
      null: true

    field :faction_id, Integer,
      null: true

    field :faction, Types::EveFactionType,
      null: true

    field :corporations_count, Integer,
      description: "Eve Alliance corporations count",
      null: true

    field :characters_count, Integer,
      description: "Eve Alliance characters count",
      null: true

    field :corporations, Types::EveCorporationType.connection_type,
      description: "Eve Alliance corporations collection",
      null: true

    field :characters, Types::EveCharacterType.connection_type,
      description: "Eve Alliance characters collection",
      null: true

    # TODO: corporation_alliance_histories
    # field :history, [Types::AllianceHistoryType], null: true

    def id
      object.alliance_id
    end
  end
end
