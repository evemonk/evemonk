# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class StargateDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      name: Field::String,
      system: Field::BelongsTo,
      type: Field::BelongsTo,
      destination_stargate: Field::BelongsTo,
      destination_system: Field::BelongsTo,
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
      :destination_stargate,
      :destination_system,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(stargate)
      stargate.name
    end
  end
end
