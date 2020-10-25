# frozen_string_literal: true

module Types
  class EveBloodlineType < Types::BaseObject
    field :id, ID, null: false
    field :name, GraphQL::Types::JSON, null: true
    field :description, GraphQL::Types::JSON, null: true
    field :corporation_id, Integer, null: true
    field :corporation, Types::EveCorporationType, null: true
    field :race_id, Integer, null: true
    field :race, Types::EveRaceType, null: true
    field :ship_type_id, Integer, null: true
    field :ship_type, Types::EveShipType, null: true
    field :charisma, Integer, null: true
    field :intelligence, Integer, null: true
    field :memory, Integer, null: true
    field :perception, Integer, null: true
    field :willpower, Integer, null: true
    field :ancestries, Types::EveAncestryType.connection_type, null: true

    def id
      object.bloodline_id
    end

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
