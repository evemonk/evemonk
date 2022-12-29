# frozen_string_literal: true

module Types
  class EveConstellationType < Types::BaseObject
    description "Constellation object"

    field :id, ID,
      description: "Constellation ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :region_id, Integer,
      description: "Region ID",
      null: true

    field :region, Types::EveRegionType,
      description: "Region",
      null: true

    field :systems, Types::EveSystemType.connection_type,
      description: "Systems collection",
      null: true

    # TODO: position
  end
end
