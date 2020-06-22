# frozen_string_literal: true

module Types
  class EveStationType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :max_dockable_ship_volume, Float, null: true
    field :office_rental_cost, Float, null: true
    # t.bigint "owner"
    field :race_id, Integer, null: true
    field :race, Types::EveRaceType, null: true
    field :reprocessing_efficiency, Float, null: true
    field :reprocessing_stations_take, Float, null: true
    field :services, [String], null: true
    # t.bigint "system_id"
    # t.bigint "type_id"

    def id
      object.station_id
    end
  end
end
