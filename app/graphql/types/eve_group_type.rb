# frozen_string_literal: true

module Types
  class EveGroupType < Types::BaseObject
    description "Group object"

    field :id, ID,
      method: :group_id,
      description: "Group ID",
      null: false

    field :name, GraphQL::Types::JSON,
      description: "Name",
      null: true

    field :published, Boolean,
      description: "Published",
      null: true

    field :category_id, Integer,
      description: "Category ID",
      null: true

    field :category, Types::EveCategoryType,
      description: "Category",
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
  end
end
