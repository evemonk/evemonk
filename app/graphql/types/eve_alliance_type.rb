# frozen_string_literal: true

module Types
  class EveAllianceType < Types::BaseObject
    description "Eve Alliance object"

    field :id, ID, null: false, description: "Eve Alliance ID"
    field :name, String, null: true, description: "Eve Alliance name"
    field :ticker, String, null: true, description: "Eve Alliance ticker"
    field :date_founded, GraphQL::Types::ISO8601DateTime, null: true
    field :creator_corporation_id, Integer, null: true
    field :creator_corporation, Types::EveCorporationType, null: true
    field :creator_id, Integer, null: true
    field :creator, Types::EveCharacterType, null: true
    field :executor_corporation_id, Integer, null: true
    field :executor_corporation, Types::EveCorporationType, null: true
    field :faction_id, Integer, null: true
    field :faction, Types::EveFactionType, null: true
    field :corporations_count, Integer, null: true, description: "Eve Alliance corporations count"
    field :characters_count, Integer, null: true, description: "Eve Alliance characters count"
    field :corporations, Types::EveCorporationType.connection_type, null: true, description: "Eve Alliance corporations collection"
    field :characters, Types::EveCharacterType.connection_type, null: true, description: "Eve Alliance characters collection"
    # TODO: corporation_alliance_histories
    # field :history, [Types::AllianceHistoryType], null: true

    def id
      object.alliance_id
    end
  end
end
