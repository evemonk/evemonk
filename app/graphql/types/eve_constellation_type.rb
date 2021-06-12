# frozen_string_literal: true

module Types
  class EveConstellationType < Types::BaseObject
    description "Eve Constellation object"

    field :id, ID, null: false
    field :name, GraphQL::Types::JSON, null: true
    field :region_id, Integer, null: true
    field :region, Types::EveRegionType, null: true
    field :systems, Types::EveSystemType.connection_type, null: true
    # TODO: position

    def id
      object.constellation_id
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
  end
end
