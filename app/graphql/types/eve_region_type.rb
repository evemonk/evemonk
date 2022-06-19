# frozen_string_literal: true

module Types
  class EveRegionType < Types::BaseObject
    description "Region object"

    field :id, ID,
      method: :region_id,
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
