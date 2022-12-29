# frozen_string_literal: true

module Types
  class EveStarType < Types::BaseObject
    description "Star object"

    field :id, ID,
      description: "Star ID",
      null: false

    # field :name, String, null: true
    # field :age, Integer, null: true
    # field :luminosity, Float, null: true
    # field :radius, Integer, null: true
    # field :solar_system_id, Integer, null: true
    # field :solar_system, Types::EveSystemType, null: true
    # field :spectral_class, String, null: true
    # field :temperature, Integer, null: true
    # field :type_id, Integer, null: true
    # field :type, Types::EveTypeType, null: true
  end
end
