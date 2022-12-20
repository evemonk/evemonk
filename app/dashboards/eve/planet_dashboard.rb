# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class PlanetDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      name: Field::String,
      system: Field::BelongsTo,
      type: Field::BelongsTo,
      moons: Field::HasMany,
      asteroid_belts: Field::HasMany,
      # TODO: position
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :name,
      :system,
      :type,
      :moons,
      :asteroid_belts,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(planet)
      planet.name
    end
  end
end
