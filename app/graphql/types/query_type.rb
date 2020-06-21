# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :alliances,
      [Types::EveAllianceType],
      null: false,
      description: "Eve Alliances"

    field :corporations,
      [Types::EveCorporationType],
      null: false,
      description: "Eve Corporations"

    field :characters,
      [Types::EveCharacterType],
      null: false,
      description: "Eve Characters"

    field :factions,
      [Types::EveFactionType],
      null: false,
      description: "Eve Factions"

    field :races,
      [Types::EveRaceType],
      null: false,
      description: "Eve Races"

    field :regions,
      [Types::EveRegionType],
      null: false,
      description: "Eve Regions"

    field :contracts,
      [Types::EveContractType],
      null: false,
      description: "Public Contracts"

    def alliances
      ::Eve::Alliance.all.decorate
    end

    def corporations
      ::Eve::Corporation.all.decorate
    end

    def characters
      ::Eve::Character.all.decorate
    end

    def factions
      ::Eve::Faction.all.decorate
    end

    def races
      ::Eve::Race.all.decorate
    end

    def regions
      ::Eve::Region.all.decorate
    end

    def contracts
      ::Eve::Contract.all.decorate
    end
  end
end
