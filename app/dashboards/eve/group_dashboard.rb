# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class GroupDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      category_id: Field::Number, # TODO: add later
      bloodline: Field::BelongsTo.with_options(class_name: "Eve::Bloodline"),
      name_en: Field::String,
      name_de: Field::String,
      name_fr: Field::String,
      name_ja: Field::String,
      name_ru: Field::String,
      name_ko: Field::String,
      published: Field::Boolean,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name_en].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      # :category,
      :name_en,
      :name_de,
      :name_fr,
      :name_ja,
      :name_ru,
      :name_ko,
      :published,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(group)
      group.name
    end
  end
end
