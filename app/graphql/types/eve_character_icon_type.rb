# frozen_string_literal: true

module Types
  class EveCharacterIconType < Types::BaseObject
    description "Character Icon object"

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

    field :gigantic, String,
      description: "URL to gigantic icon",
      method: :icon_gigantic,
      null: true
  end
end
