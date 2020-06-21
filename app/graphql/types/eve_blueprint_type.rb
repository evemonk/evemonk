# frozen_string_literal: true

module Types
  class EveBlueprintType < Types::BaseObject
    field :id, ID, null: false
    field :name, GraphQL::Types::JSON, null: true
    field :description, GraphQL::Types::JSON, null: true
    field :capacity, Float, null: true


    # t.bigint "graphic_id"
    # t.bigint "group_id"
    # t.bigint "icon_id"
    # t.bigint "market_group_id"
    # t.float "mass"
    # t.float "packaged_volume"
    # t.integer "portion_size"
    # t.boolean "published"
    # t.float "radius"
    # t.float "volume"

    # t.float "base_price"
    # t.float "adjusted_price"
    # t.float "average_price"

    # t.bigint "copying_time"
    # t.integer "max_production_limit"
    # t.bigint "manufacturing_time"
    # t.bigint "research_material_time"
    # t.bigint "research_time_time"
    # t.bigint "invention_time"

    def id
      object.type_id
    end

    def name
      {
        en: object.name_en,
        de: object.name_de,
        fr: object.name_fr,
        ja: object.name_ja,
        ru: object.name_ru,
        zh: object.name_zh,
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
        zh: object.description_zh,
        ko: object.description_ko
      }
    end
  end
end
