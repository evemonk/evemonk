# frozen_string_literal: true

module Types
  class EveIconType < Types::BaseObject
    description "Icon object"

    field :id, ID,
      description: "Icon ID",
      null: false

    field :description, String,
      description: "Description",
      null: true

    field :icon_file, String,
      description: "Icon file",
      null: true

    field :obsolete, Boolean,
      description: "Obsolete",
      null: true
  end
end
