# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class StationDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      name: Field::String,
      system: Field::BelongsTo,
      type: Field::BelongsTo,
      owner: Field::Number,
      race: Field::BelongsTo,
      max_dockable_ship_volume: Field::Number,
      office_rental_cost: Field::Number,
      reprocessing_efficiency: Field::Number,
      reprocessing_stations_take: Field::Number,
      # TODO: t.string "services", array: true
      # services: Field::String,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
      # position: Field::HasOne
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :name,
      :system,
      :type,
      :owner,
      :race,
      :max_dockable_ship_volume,
      :office_rental_cost,
      :reprocessing_efficiency,
      :reprocessing_stations_take,
      # :services,
      :created_at,
      :updated_at
      # :position
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(station)
      station.name
    end
  end
end
