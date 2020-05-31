# frozen_string_literal: true

require "administrate/base_dashboard"

class SettingDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    var: Field::String,
    value: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }

  COLLECTION_ATTRIBUTES = [
    :id,
    :var,
    :value,
    :created_at
  ]

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :var,
    :value,
    :created_at,
    :updated_at
  ]

  FORM_ATTRIBUTES = [
    :var,
    :value
  ]

  COLLECTION_FILTERS = {}
end
