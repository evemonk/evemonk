# frozen_string_literal: true

module Types
  class EveFactionType < Types::BaseObject
    description "Faction object"

    field :id, ID,
      description: "Faction ID",
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

    field :is_unique, Boolean,
      description: "Is Unique?",
      null: true

    field :militia_corporation_id, Integer,
      description: "Militia Corporation ID (Corporation ID)",
      null: true

    field :militia_corporation, Types::EveCorporationType,
      description: "Militia Corporation (Corporation)",
      null: true

    field :size_factor, Float,
      description: "Size factor",
      null: true

    field :solar_system_id, Integer,
      description: "Solar System ID (System ID)",
      null: true

    field :solar_system, Types::EveSystemType,
      description: "Solar System (System)",
      null: true

    field :station_count, Integer,
      description: "Station count",
      null: true

    field :station_system_count, Integer,
      description: "Station system count",
      null: true

    field :alliances, Types::EveAllianceType.connection_type,
      description: "Alliances collection",
      null: true

    # field :standings
  end
end
