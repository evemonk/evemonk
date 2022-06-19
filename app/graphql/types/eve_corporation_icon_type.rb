# frozen_string_literal: true

module Types
  class EveCorporationIconType < Types::BaseObject
    description "Corporation Icon object"

    field :tiny, String,
      description: "URL to tiny icon",
      method: :icon_tiny,
      null: true

    field :small, String,
      description: "URL to small icon",
      method: :icon_small,
      null: true

    field :medium, String,
      description: "URL to medium icon",
      method: :icon_medium,
      null: true

    field :large, String,
      description: "URL to large icon",
      method: :icon_large,
      null: true
  end
end
