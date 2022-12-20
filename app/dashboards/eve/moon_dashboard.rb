# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class MoonDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      name: Field::String,
      system: Field::BelongsTo,
      planet: Field::BelongsTo,
      # TODO: add "position"
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :name,
      :system,
      :planet,
      # :position,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(moon)
      moon.name
    end
  end
end
