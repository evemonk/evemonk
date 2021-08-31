# frozen_string_literal: true

module Types
  class EveIconType < Types::BaseObject
    description "Icon object"

    field :id, ID,
      method: :icon_id,
      null: false

    field :description, String,
      null: true

    field :icon_file, String,
      null: true

    field :obsolete, Boolean,
      null: true
  end
end
