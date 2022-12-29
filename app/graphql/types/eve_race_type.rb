# frozen_string_literal: true

module Types
  class EveRaceType < Types::BaseObject
    description "Race object"

    field :id, ID,
      description: "Race ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :description, EveDescriptionType,
      description: "Description object",
      method: :itself,
      null: true

    field :faction_id, Integer,
      description: "Faction ID",
      null: true

    field :faction, Types::EveFactionType,
      description: "Faction",
      null: true

    field :bloodlines, Types::EveBloodlineType.connection_type,
      description: "Bloodlines collection",
      null: true

    field :stations, Types::EveStationType.connection_type,
      description: "Stations collection",
      null: true
  end
end
