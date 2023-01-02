# frozen_string_literal: true

module Types
  class EveCharacterType < Types::BaseObject
    description "Character object"

    field :id, ID,
      description: "Character ID",
      null: false

    field :icon, EveCharacterIconType,
      description: "Eve Character Icons",
      method: :itself,
      null: true

    field :alliance_id, Integer,
      description: "Alliance ID",
      null: true

    field :alliance, Types::EveAllianceType,
      description: "Alliance",
      null: true

    field :birthday, GraphQL::Types::ISO8601DateTime,
      description: "Birthday",
      null: true

    field :bloodline_id, Integer,
      description: "Bloodline ID",
      null: true

    field :bloodline, Types::EveBloodlineType,
      description: "Bloodline",
      null: true

    field :corporation_id, Integer,
      description: "Corporation ID",
      null: true

    field :corporation, Types::EveCorporationType,
      description: "Corporation",
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

    # TODO: make this enum?
    field :gender, String,
      description: "Gender",
      null: true

    field :name, String,
      description: "Name",
      null: true

    field :race_id, Integer,
      description: "Race ID",
      null: true

    field :race, Types::EveRaceType,
      description: "Race",
      null: true

    field :security_status, Float,
      description: "Security status",
      null: true

    field :title, String,
      description: "Title",
      null: true
  end
end
