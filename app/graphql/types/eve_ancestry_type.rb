# frozen_string_literal: true

module Types
  class EveAncestryType < Types::BaseObject
    description "Eve Ancestry object"

    field :id, ID,
      method: :ancestry_id,
      null: false

    field :name, GraphQL::Types::JSON,
      null: true

    field :description, GraphQL::Types::JSON,
      null: true

    field :bloodline_id, Integer,
      null: true

    field :bloodline, Types::EveBloodlineType,
      null: true

    field :icon_id, Integer,
      null: true

    field :icon, Types::EveIconType,
      null: true

    field :short_description, String,
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
