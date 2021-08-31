# frozen_string_literal: true

module Types
  class EveContractType < Types::BaseObject
    description "Contract object"

    field :id, ID,
      method: :contract_id,
      description: "Contract ID",
      null: false

    # field :buyout, Float, null: true
    # field :collateral, Float, null: true
    # field :date_expired, GraphQL::Types::ISO8601DateTime, null: true
    # field :date_issued, GraphQL::Types::ISO8601DateTime, null: true
    # field :days_to_complete, Integer, null: true
    # # field :end_location_id, Integer, null: true
    # field :for_corporation, Boolean, null: true
    # field :issuer_corporation_id, Integer, null: true
    # field :issuer_corporation, Types::EveCorporationType, null: true
    # field :issuer_id, Integer, null: true
    # field :issuer, Types::EveCharacterType, null: true
    # field :price, Float, null: true
    # field :reward, Float, null: true
    # # field :start_location_id, Integer, null: true
    # field :title, String, null: true
    # field :kind, String, null: true
    # field :volume, Float, null: true
    # field :region_id, Integer, null: true
    # field :region, Types::EveRegionType, null: true
  end
end
