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

    field :contracts,
      [Types::EveContractType],
      null: false,
      description: "Public Contracts"

    def alliances
      ::Eve::Alliance.all
    end

    def corporations
      ::Eve::Corporation.all
    end

    def characters
      ::Eve::Character.all
    end

    def factions
      ::Eve::Faction.all
    end

    def contracts
      ::Eve::Contract.all
    end
  end
end
