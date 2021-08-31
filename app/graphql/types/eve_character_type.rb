# frozen_string_literal: true

module Types
  class EveCharacterType < Types::BaseObject
    description "Character object"

    field :id, ID,
      method: :character_id,
      null: false

    field :alliance_id, Integer,
      null: true

    field :alliance, Types::EveAllianceType,
      null: true

    field :ancestry_id, Integer,
      null: true

    field :ancestry, Types::EveAncestryType,
      null: true

    field :birthday, GraphQL::Types::ISO8601DateTime,
      null: true

    field :bloodline_id, Integer,
      null: true

    field :bloodline, Types::EveBloodlineType,
      null: true

    field :corporation_id, Integer,
      null: true

    field :corporation, Types::EveCorporationType,
      null: true

    field :description, String,
      method: :sanitized_description,
      null: true

    field :faction_id, Integer,
      null: true

    field :faction, Types::EveFactionType,
      null: true

    field :gender, String,
      null: true

    field :name, String,
      null: true

    field :race_id, Integer,
      null: true

    field :race, Types::EveRaceType,
      null: true

    field :security_status, Float,
      null: true

    field :title, String,
      null: true
  end
end
