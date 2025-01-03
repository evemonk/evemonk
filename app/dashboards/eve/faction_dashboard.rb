# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class FactionDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      corporation: Field::BelongsTo,
      description_en: Field::Text,
      description_de: Field::Text,
      description_fr: Field::Text,
      description_ja: Field::Text,
      description_ko: Field::Text,
      description_zh: Field::Text,
      description_es: Field::Text,
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ko: Field::String,
      name_zh: Field::String,
      name_es: Field::String,
      is_unique: Field::Boolean,
      militia_corporation: Field::BelongsTo,
      size_factor: Field::Number,
      solar_system: Field::BelongsTo,
      station_count: Field::Number,
      station_system_count: Field::Number,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name_en].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :corporation,
      :description_en,
      :description_de,
      :description_fr,
      :description_ja,
      :description_ko,
      :description_zh,
      :description_es,
      :name_en,
      :name_de,
      :name_fr,
      :name_ja,
      :name_ko,
      :name_zh,
      :name_es,
      :is_unique,
      :militia_corporation,
      :size_factor,
      :solar_system,
      :station_count,
      :station_system_count,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(faction)
      faction.name
    end
  end
end
