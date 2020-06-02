# frozen_string_literal: true

require "administrate/base_dashboard"

module Eve
  class CharacterDashboard < Administrate::BaseDashboard
    ATTRIBUTE_TYPES = {
      id: Field::Number,
      character_id: Field::Number,
      alliance: Field::BelongsTo.with_options(class_name: "Eve::Alliance"),
      ancestry: Field::BelongsTo.with_options(class_name: "Eve::Ancestry"),
      birthday: Field::DateTime,
      bloodline: Field::BelongsTo.with_options(class_name: "Eve::Bloodline"),
      corporation: Field::BelongsTo.with_options(class_name: "Eve::Corporation"),
      description: Field::Text,
      faction_id: Field::Number, # TODO: faction
      gender: Field::String,
      name: Field::String,
      race: Field::BelongsTo.with_options(class_name: "Eve::Race"),
      security_status: Field::Number,
      title: Field::String,
      created_at: Field::DateTime,
      updated_at: Field::DateTime
    }.freeze

    COLLECTION_ATTRIBUTES = [:id, :character_id, :name].freeze

    SHOW_PAGE_ATTRIBUTES = [
      :id,
      :character_id,
      :alliance,
      :ancestry,
      :birthday,
      :bloodline,
      :corporation,
      :description,
      :faction_id, # TODO: faction
      :gender,
      :name,
      :race,
      :security_status,
      :title,
      :created_at,
      :updated_at
    ].freeze

    FORM_ATTRIBUTES = [
      :character_id,
      :alliance,
      :ancestry,
      :birthday,
      :bloodline,
      :corporation,
      :description,
      :faction_id, # TODO: faction
      :gender,
      :name,
      :race,
      :security_status,
      :title
    ].freeze

    COLLECTION_FILTERS = {}.freeze

    def display_resource(character)
      character.name
    end
  end
end
