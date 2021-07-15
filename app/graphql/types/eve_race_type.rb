# frozen_string_literal: true

module Types
  class EveRaceType < Types::BaseObject
    description "Eve Race object"

    field :id, ID,
      method: :race_id,
      null: false

    field :name, GraphQL::Types::JSON,
      null: true

    field :description, GraphQL::Types::JSON,
      null: true

    field :faction_id, Integer,
      null: true

    field :faction, Types::EveFactionType,
      null: true

    field :bloodlines, Types::EveBloodlineType.connection_type,
      null: true

    field :stations, Types::EveStationType.connection_type,
      null: true

    def name
      {
        en: object.name_en,
        de: object.name_de,
        fr: object.name_fr,
        ja: object.name_ja,
        ru: object.name_ru,
        ko: object.name_ko
      }
    end

    def description
      {
        en: object.description_en,
        de: object.description_de,
        fr: object.description_fr,
        ja: object.description_ja,
        ru: object.description_ru,
        ko: object.description_ko
      }
    end
  end
end
