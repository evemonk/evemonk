# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class CategoryDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ko: Field::String,
      name_zh: Field::String,
      name_es: Field::String,
      published: Field::Boolean,
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
      :name_ko,
      :name_zh,
      :name_es,
      :published,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(category)
      category.name
    end
  end
end
