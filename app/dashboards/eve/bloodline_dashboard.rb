# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class BloodlineDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ru: Field::String,
      name_ko: Field::String,
      description_en: Field::Text,
      description_de: Field::Text,
      description_fr: Field::Text,
      description_ja: Field::Text,
      description_ru: Field::Text,
      description_ko: Field::Text,
      race: Field::BelongsTo,
      charisma: Field::Number,
      intelligence: Field::Number,
      memory: Field::Number,
      perception: Field::Number,
      willpower: Field::Number,
      corporation: Field::BelongsTo,
      # ship_type: Field::BelongsTo.with_options(class_name: "Eve::Ship"), TODO
      created_at: Field::DateTime,
      updated_at: Field::DateTime,
      ancestries: Field::HasMany
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
      :description_en,
      :description_de,
      :description_fr,
      :description_ja,
      :description_ru,
      :description_ko,
      :race,
      :charisma,
      :intelligence,
      :memory,
      :perception,
      :willpower,
      :corporation,
      # :ship_type,
      :created_at,
      :updated_at,
      :ancestries
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(bloodline)
      bloodline.name
    end
  end
end
