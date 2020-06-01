# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class RaceDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      race_id: Field::Number,
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ru: Field::String,
      name_zh: Field::String,
      name_ko: Field::String,
      description_en: Field::Text,
      description_de: Field::Text,
      description_fr: Field::Text,
      description_ja: Field::Text,
      description_ru: Field::Text,
      description_zh: Field::Text,
      description_ko: Field::Text,
      # alliance: Field::BelongsTo.with_options(class_name: "Eve::Alliance"),
      bloodlines: Field::HasMany.with_options(class_name: "Eve::Bloodline"),
      # stations: Field::HasMany.with_options(class_name: "Eve::Station"),
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :race_id, :name_en, :bloodlines].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :race_id,
      :name_en,
      :name_de,
      :name_fr,
      :name_ja,
      :name_ru,
      :name_zh,
      :name_ko,
      :description_en,
      :description_de,
      :description_fr,
      :description_ja,
      :description_ru,
      :description_zh,
      :description_ko,
      # :alliance,
      :bloodlines,
      :created_at,
      :updated_at
    ].freeze

    FORM_ATTRIBUTES = [
      :race_id,
      :name_en,
      :name_de,
      :name_fr,
      :name_ja,
      :name_ru,
      :name_zh,
      :name_ko,
      :description_en,
      :description_de,
      :description_fr,
      :description_ja,
      :description_ru,
      :description_zh,
      :description_ko,
      # :alliance
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(race)
      race.name
    end
  end
end
