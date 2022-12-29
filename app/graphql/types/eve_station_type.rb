# frozen_string_literal: true

module Types
  class EveStationType < Types::BaseObject
    description "Station object"

    field :id, ID,
      description: "Station ID",
      null: false

    # field :name, String, null: true
    # field :max_dockable_ship_volume, Float, null: true
    # field :office_rental_cost, Float, null: true
    # # t.bigint "owner"
    # field :race_id, Integer, null: true
    # field :race, Types::EveRaceType, null: true
    # field :reprocessing_efficiency, Float, null: true
    # field :reprocessing_stations_take, Float, null: true
    # field :services, [String], null: true
    # field :system_id, Integer, null: true
    # field :system, Types::EveSystemType, null: true
    # field :type_id, Integer, null: true
    # field :type, Types::EveTypeType, null: true
  end
end
