# frozen_string_literal: true

module Types
  class EveAncestryType < Types::BaseObject
    description "Ancestry object"

    field :id, ID,
      description: "Ancestry ID",
      null: false

    field :name, EveNameType,
      description: "Name object",
      method: :itself,
      null: true

    field :description, EveDescriptionType,
      description: "Description object",
      method: :itself,
      null: true

    field :bloodline_id, Integer,
      description: "Bloodline ID",
      null: true

    field :bloodline, Types::EveBloodlineType,
      description: "Bloodline",
      null: true

    field :icon_id, Integer,
      description: "Icon ID",
      null: true

    field :icon, Types::EveIconType,
      description: "Icon",
      null: true

    field :short_description, String,
      description: "Short description",
      null: true
  end
end
