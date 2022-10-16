# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class CharacterDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      alliance: Field::BelongsTo,
      ancestry: Field::BelongsTo,
      birthday: Field::DateTime,
      bloodline: Field::BelongsTo,
      corporation: Field::BelongsTo,
      description: Field::Text,
      faction: Field::BelongsTo,
      gender: Field::String,
      name: Field::String,
      race: Field::BelongsTo,
      security_status: Field::Number,
      title: Field::String,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :alliance,
      :ancestry,
      :birthday,
      :bloodline,
      :corporation,
      :description,
      :faction,
      :gender,
      :name,
      :race,
      :security_status,
      :title,
      :created_at,
      :updated_at
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(character)
      character.name
    end
  end
end
