# frozen_string_literal: true

module Types
  class EveMarketGroupType < Types::BaseObject
    description "MarketGroup object"

    field :id, ID,
      method: :market_group_id,
      description: "MarketGroup ID",
      null: false

    field :name, GraphQL::Types::JSON,
      description: "Name",
      null: true

    field :description, GraphQL::Types::JSON,
      description: "Description",
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

    def name
      {
        en: object.name_en,
        de: object.name_de,
        fr: object.name_fr,
        ja: object.name_ja,
        ru: object.name_ru,
        ko: object.name_ko
      }
    end

    def description
      {
        en: object.description_en,
        de: object.description_de,
        fr: object.description_fr,
        ja: object.description_ja,
        ru: object.description_ru,
        ko: object.description_ko
      }
    end
  end
end
