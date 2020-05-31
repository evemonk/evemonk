# frozen_string_literal: true

require "administrate/base_dashboard"

class SettingDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    var: Field::String,
    value: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    var
    value
    created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    var
    value
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    var
    value
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
