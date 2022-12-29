# frozen_string_literal: true

module Types
  class EveSystemType < Types::BaseObject
    description "System object"

    field :id, ID,
      description: "System ID",
      null: false

    # field :name, GraphQL::Types::JSON, null: true
    # field :constellation_id, Integer, null: true
    # field :constellation, Types::EveConstellationType, null: true
    # field :star_id, Integer, null: true
    # field :star, Types::EveStarType, null: true
    # field :security_class, String, null: true
    # field :security_status, Float, null: true

    # def name
    #   {
    #     en: object.name_en,
    #     de: object.name_de,
    #     fr: object.name_fr,
    #     ja: object.name_ja,
    #     ru: object.name_ru,
    #     ko: object.name_ko
    #   }
    # end
  end
end
