# frozen_string_literal: true

module Types
  class EveAllianceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :ticker, String, null: true
    field :date_founded, GraphQL::Types::ISO8601DateTime, null: true
    # field :creator_corporation, EveCorporationType, null: true
    # field :creator, EveCharacterType, null: true
    # field :executor_corporation
    # field :faction
    field :corporations_count, Integer, null: true
    field :characters_count, Integer, null: true

    def id
      object.alliance_id
    end
  end
end
