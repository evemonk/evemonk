# frozen_string_literal: true

module Types
  class EveNameType < Types::BaseObject
    description "Name object"

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
      object.name_en
    end

    def de
      object.name_de
    end

    def fr
      object.name_fr
    end

    def ja
      object.name_ja
    end

    def ru
      object.name_ru
    end

    def ko
      object.name_ko
    end
  end
end
