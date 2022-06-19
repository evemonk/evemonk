# frozen_string_literal: true

module Types
  class EveDescriptionType < Types::BaseObject
    description "Description object"

    field :en, String,
      description: "English",
      null: true

    field :de, String,
      description: "Deutsch",
      null: true

    field :fr, String,
      description: "French",
      null: true

    field :ja, String,
      description: "Japanese",
      null: true

    field :ru, String,
      description: "Russian",
      null: true

    field :ko, String,
      description: "Korean",
      null: true

    def en
      object.description_en
    end

    def de
      object.description_de
    end

    def fr
      object.description_fr
    end

    def ja
      object.description_ja
    end

    def ru
      object.description_ru
    end

    def ko
      object.description_ko
    end
  end
end
