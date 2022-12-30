# frozen_string_literal: true

module Types
  class EveRegionType < Types::BaseObject
    description "Region object"

    field :id, ID,
      description: "Region ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :description, EveDescriptionType,
      description: "Description object",
      method: :itself,
      null: true

    field :constellations, Types::EveConstellationType.connection_type,
      description: "Constellations collection",
      null: true

    field :contracts, Types::EveContractType.connection_type,
      description: "Contracts collection",
      null: true
  end
end
