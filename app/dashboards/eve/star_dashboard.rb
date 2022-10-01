# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class StarDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      star_id: Field::Number,
      age: Field::Number,
      luminosity: Field::Number,
      name: Field::String,
      radius: Field::Number,
      solar_system: Field::BelongsTo,
      spectral_class: Field::String,
      temperature: Field::Number,
      type: Field::BelongsTo, # TODO: check
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :star_id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :star_id,
      :age,
      :luminosity,
      :name,
      :radius,
      :solar_system,
      :spectral_class,
      :temperature,
      :type,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(star)
      star.name
    end
  end
end
