# frozen_string_literal: true

module Types
  class EveCategoryType < Types::BaseObject
    description "Category object"

    field :id, ID,
      method: :category_id,
      null: false

    field :name, GraphQL::Types::JSON,
      null: true

    field :published, Boolean,
      null: true

    field :groups, Types::EveGroupType.connection_type,
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
