# frozen_string_literal: true

module Types
  class EveBloodlineType < Types::BaseObject
    description "Bloodline object"

    field :id, ID,
      method: :bloodline_id,
      description: "Bloodline ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :description, EveDescriptionType,
      description: "Description object",
      method: :itself,
      null: true

    field :corporation_id, Integer,
      description: "Corporation ID",
      null: true

    field :corporation, Types::EveCorporationType,
      description: "Corporation",
      null: true

    field :race_id, Integer,
      description: "Race ID",
      null: true

    field :race, Types::EveRaceType,
      description: "Race",
      null: true

    field :ship_type_id, Integer,
      description: "Ship Type ID (Ship ID)",
      null: true

    field :ship_type, Types::EveShipType,
      description: "Ship Type (Ship)",
      null: true

    field :charisma, Integer,
      description: "Charisma",
      null: true

    field :intelligence, Integer,
      description: "Intelligence",
      null: true

    field :memory, Integer,
      description: "Memory",
      null: true

    field :perception, Integer,
      description: "Perception",
      null: true

    field :willpower, Integer,
      description: "Willpower",
      null: true

    field :ancestries, Types::EveAncestryType.connection_type,
      description: "Ancestries collection",
      null: true
  end
end
