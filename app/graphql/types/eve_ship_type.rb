# frozen_string_literal: true

module Types
  class EveShipType < Types::BaseObject
    description "Ship object"

    field :id, ID,
      description: "Ship ID",
      null: false

    # field :name, GraphQL::Types::JSON, null: true
    # field :description, GraphQL::Types::JSON, null: true
    # field :capacity, Float, null: true
    # field :graphic_id, Integer, null: true
    # field :graphic, Types::EveGraphicType, null: true
    # field :group_id, Integer, null: true
    # field :group, Types::EveGroupType, null: true
    # field :icon_id, Integer, null: true
    # field :icon, Types::EveIconType, null: true
    # field :market_group_id, Integer, null: true
    # field :market_group, Types::EveMarketGroupType, null: true
    # field :mass, Float, null: true
    # field :packaged_volume, Float, null: true
    # field :portion_size, Integer, null: true
    # field :published, Boolean, null: true
    # field :radius, Float, null: true
    # field :volume, Float, null: true
    # field :base_price, Float, null: true
    # field :adjusted_price, Float, null: true
    # field :average_price, Float, null: true

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
    #
    # def description
    #   {
    #     en: object.description_en,
    #     de: object.description_de,
    #     fr: object.description_fr,
    #     ja: object.description_ja,
    #     ru: object.description_ru,
    #     ko: object.description_ko
    #   }
    # end
  end
end
