# frozen_string_literal: true

module Types
  class EveAncestryType < Types::BaseObject
    description "Ancestry object"

    field :id, ID,
      method: :ancestry_id,
      description: "Ancestry ID",
      null: false

    field :name, GraphQL::Types::JSON,
      description: "Name",
      null: true

    field :description, GraphQL::Types::JSON,
      description: "Description",
      null: true

    field :bloodline_id, Integer,
      description: "Bloodline ID",
      null: true

    field :bloodline, Types::EveBloodlineType,
      description: "Bloodline",
      null: true

    field :icon_id, Integer,
      description: "Icon ID",
      null: true

    field :icon, Types::EveIconType,
      description: "Icon",
      null: true

    field :short_description, String,
      description: "Short description",
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
