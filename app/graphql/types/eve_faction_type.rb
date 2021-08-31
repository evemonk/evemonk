# frozen_string_literal: true

module Types
  class EveFactionType < Types::BaseObject
    description "Eve Faction object"

    field :id, ID,
      method: :faction_id,
      description: "Faction ID",
      null: false

    field :corporation_id, Integer,
      description: "Corporation ID",
      null: true

    field :corporation, Types::EveCorporationType,
      description: "Corporation",
      null: true

    field :description, GraphQL::Types::JSON,
      description: "Description",
      null: true

    field :is_unique, Boolean,
      description: "Is Unique?",
      null: true

    field :name, GraphQL::Types::JSON,
      description: "Name",
      null: true

    field :militia_corporation_id, Integer,
      null: true

    field :militia_corporation, Types::EveCorporationType,
      null: true

    field :size_factor, Float,
      null: true

    field :solar_system_id, Integer,
      null: true

    field :solar_system, Types::EveSystemType,
      null: true

    field :station_count, Integer,
      null: true

    field :station_system_count, Integer,
      null: true

    field :alliances, Types::EveAllianceType.connection_type,
      null: true

    # field :standings

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
  end
end
