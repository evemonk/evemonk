# frozen_string_literal: true

module Types
  class EveDescriptionType < Types::BaseObject
    description "Description object"

    field :en, String,
      description: "English",
      method: :description_en,
      null: true

    field :de, String,
      description: "Deutsch",
      method: :description_de,
      null: true

    field :fr, String,
      description: "French",
      method: :description_fr,
      null: true

    field :ja, String,
      description: "Japanese",
      method: :description_ja,
      null: true

    field :ru, String,
      description: "Russian",
      method: :description_ru,
      null: true

    field :ko, String,
      description: "Korean",
      method: :description_ko,
      null: true
  end
end
