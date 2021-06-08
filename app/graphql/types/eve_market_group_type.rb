# frozen_string_literal: true

module Types
  class EveMarketGroupType < Types::BaseObject
    description "Eve MarketGroup object"

    field :id, ID, null: false
    field :name, GraphQL::Types::JSON, null: true
    field :description, GraphQL::Types::JSON, null: true
    field :parent_group_id, Integer, null: true
    field :parent_group, Types::EveMarketGroupType, null: true
    field :types, Types::EveTypeType.connection_type, null: true

    def id
      object.market_group_id
    end

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
