# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class IconDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      description: Field::String,
      icon_file: Field::String,
      obsolete: Field::Boolean,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :description].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :description,
      :icon_file,
      :obsolete,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(icon)
      icon.description
    end
  end
end
