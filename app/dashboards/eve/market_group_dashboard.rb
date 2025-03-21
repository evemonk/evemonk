# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class MarketGroupDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      parent_group: Field::BelongsTo,
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ko: Field::String,
      description_en: Field::Text,
      description_de: Field::Text,
      description_fr: Field::Text,
      description_ja: Field::Text,
      description_ko: Field::Text,
      has_types: Field::Boolean,
      subgroups: Field::HasMany,
      icon: Field::BelongsTo,
      types: Field::HasMany,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name_en].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :parent_group,
      :name_en,
      :name_de,
      :name_fr,
      :name_ja,
      :name_ko,
      :description_en,
      :description_de,
      :description_fr,
      :description_ja,
      :description_ko,
      :has_types,
      :subgroups,
      :icon,
      :types,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(market_group)
      market_group.name
    end
  end
end
