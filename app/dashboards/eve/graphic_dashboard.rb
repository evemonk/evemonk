# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class GraphicDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      collision_file: Field::String,
      graphic_file: Field::String,
      icon_folder: Field::String,
      sof_dna: Field::String,
      sof_fation_name: Field::String,
      sof_hull_name: Field::String,
      sof_race_name: Field::String,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :collision_file,
      :graphic_file,
      :icon_folder,
      :sof_dna,
      :sof_fation_name,
      :sof_hull_name,
      :sof_race_name,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze
  end
end
