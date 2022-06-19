# frozen_string_literal: true

module Types
  class EveAllianceIconType < Types::BaseObject
    description "Alliance Icon object"

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

    field :huge, String,
      description: "URL to huge icon",
      method: :icon_huge,
      null: true
  end
end
