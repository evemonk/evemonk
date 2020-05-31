# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class AllianceDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      alliance_id: Field::Number,
      creator_corporation_id: Field::Number,
      creator_id: Field::Number,
      date_founded: Field::DateTime,
      executor_corporation_id: Field::Number,
      faction_id: Field::Number,
      name: Field::String,
      ticker: Field::String,
      corporations_count: Field::Number,
      characters_count: Field::Number,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:alliance_id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :alliance_id,
      :creator_corporation_id,
      :creator_id,
      :date_founded,
      :executor_corporation_id,
      :faction_id,
      :name,
      :ticker,
      :corporations_count,
      :characters_count,
      :created_at,
      :updated_at
    ].freeze

    FORM_ATTRIBUTES = [
      :alliance_id,
      :creator_corporation_id,
      :creator_id,
      :date_founded,
      :executor_corporation_id,
      :faction_id,
      :name,
      :ticker,
      :corporations_count,
      :characters_count
    ].freeze

    COLLECTION_FILTERS = {}.freeze
  end
end
