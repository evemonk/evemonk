# frozen_string_literal: true

module Types
  class EveMarketGroupType < Types::BaseObject
    description "MarketGroup object"

    field :id, ID,
      description: "MarketGroup ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :description, EveDescriptionType,
      description: "Description object",
      method: :itself,
      null: true

    field :parent_group_id, Integer,
      description: "Parent Group ID (MarketGroup ID)",
      null: true

    field :parent_group, Types::EveMarketGroupType,
      description: "Parent Group (MarketGroup)",
      null: true

    field :types, Types::EveTypeType.connection_type,
      description: "Types collection",
      null: true
  end
end
