# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :alliances,
          [Types::EveAllianceType],
          null: false,
          description: "Eve Alliances"

    field :contracts,
          [Types::EveContractType],
          null: false,
          description: "Public Contracts"

    def contracts
      ::Eve::Contract.all
    end

    def alliances
      ::Eve::Alliance.all
    end
  end
end
