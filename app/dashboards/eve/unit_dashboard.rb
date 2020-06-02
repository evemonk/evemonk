# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class UnitDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      unit_id: Field::Number,
      description: Field::Text,
      unit_name: Field::String,
      display_name: Field::String,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :unit_id, :unit_name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :unit_id,
      :description,
      :unit_name,
      :display_name,
      :created_at,
      :updated_at
    ].freeze

    FORM_ATTRIBUTES = [
      :unit_id,
      :description,
      :unit_name,
      :display_name
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(unit)
      unit.unit_name
    end
  end
end
