# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class TypeDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ru: Field::String,
      name_ko: Field::String,
      # t.string "name_zh"
      # t.string "name_es"
      description_en: Field::Text,
      description_de: Field::Text,
      description_fr: Field::Text,
      description_ja: Field::Text,
      description_ru: Field::Text,
      description_ko: Field::Text,
      # t.text "description_zh"
      # t.text "description_es"
      capacity: Field::Number,
      graphic: Field::BelongsTo,
      group: Field::BelongsTo,
      icon: Field::BelongsTo,
      mass: Field::Number,
      packaged_volume: Field::Number,
      portion_size: Field::Number,
      published: Field::Boolean,
      radius: Field::Number,
      volume: Field::Number,
      base_price: Field::Number,
      adjusted_price: Field::Number,
      average_price: Field::Number,
      copying_time: Field::Number,
      max_production_limit: Field::Number,
      manufacturing_time: Field::Number,
      research_material_time: Field::Number,
      research_time_time: Field::Number,
      invention_time: Field::Number,
      is_blueprint: Field::Boolean,
      is_manufacturing_item: Field::Boolean,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name_en].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :name_en,
      :name_de,
      :name_fr,
      :name_ja,
      :name_ru,
      :name_ko,
      # t.string "name_zh"
      # t.string "name_es"
      :description_en,
      :description_de,
      :description_fr,
      :description_ja,
      :description_ru,
      :description_ko,
      # t.text "description_zh"
      # t.text "description_es"
      :capacity,
      :graphic,
      :group,
      :icon,
      :mass,
      :packaged_volume,
      :portion_size,
      :published,
      :radius,
      :volume,
      :base_price,
      :adjusted_price,
      :average_price,
      :copying_time,
      :max_production_limit,
      :manufacturing_time,
      :research_material_time,
      :research_time_time,
      :invention_time,
      :is_blueprint,
      :is_manufacturing_item,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(type)
      type.name
    end
  end
end
