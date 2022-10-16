# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class AgentDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      agent_type_id: Field::Number,
      corporation: Field::BelongsTo.with_options,
      division_id: Field::Number,
      is_locator: Field::Boolean,
      level: Field::Number,
      location_id: Field::Number,
      quality: Field::Number,
      name: Field::String,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :agent_type_id,
      :corporation,
      :division_id,
      :is_locator,
      :level,
      :location_id,
      :quality,
      :name,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(agent)
      agent.name
    end
  end
end
