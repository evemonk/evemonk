# frozen_string_literal: true

module Types
  class EveConstellationType < Types::BaseObject
    description "Constellation object"

    field :id, ID,
      method: :constellation_id,
      description: "Constellation ID",
      null: false

    field :name, GraphQL::Types::JSON,
      description: "Name",
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
