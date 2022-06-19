# frozen_string_literal: true

module Types
  class EveNameType < Types::BaseObject
    description "Name object"

    field :en, String,
      description: "English",
      method: :name_en,
      null: true

    field :de, String,
      description: "Deutsch",
      method: :name_de,
      null: true

    field :fr, String,
      description: "French",
      method: :name_fr,
      null: true

    field :ja, String,
      description: "Japanese",
      method: :name_ja,
      null: true

    field :ru, String,
      description: "Russian",
      method: :name_ru,
      null: true

    field :ko, String,
      description: "Korean",
      method: :name_ko,
      null: true
  end
end
