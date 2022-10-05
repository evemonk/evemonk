# frozen_string_literal: true

module Types
  class EveUnitType < Types::BaseObject
    description "Unit object"

    field :id, ID,
      description: "Unit ID",
      null: false

    field :description, String,
      description: "Unit description",
      null: true

    field :unit_name, String,
      description: "Unit name",
      null: true

    field :display_name, String,
      description: "Display name",
      null: true
  end
end
