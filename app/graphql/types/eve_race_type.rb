# frozen_string_literal: true

module Types
  class EveRaceType < Types::BaseObject
    description "Race object"

    field :id, ID,
      method: :race_id,
      description: "Race ID",
      null: false

    field :name, GraphQL::Types::JSON,
      description: "Name",
      null: true

    field :description, GraphQL::Types::JSON,
      description: "Description",
      null: true

    field :faction_id, Integer,
      description: "Faction ID",
      null: true

    field :faction, Types::EveFactionType,
      description: "Faction",
      null: true

    field :bloodlines, Types::EveBloodlineType.connection_type,
      description: "Bloodlines collection",
      null: true

    field :stations, Types::EveStationType.connection_type,
      description: "Stations collection",
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
