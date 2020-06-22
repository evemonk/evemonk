# frozen_string_literal: true

module Types
  class EveStationType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true

    def id
      object.type_id
    end

    # t.float "max_dockable_ship_volume"
    # t.float "office_rental_cost"
    # t.bigint "owner"
    # t.bigint "race_id"
    # t.float "reprocessing_efficiency"
    # t.float "reprocessing_stations_take"
    # t.string "services", array: true
    # t.bigint "station_id"
    # t.bigint "system_id"
    # t.bigint "type_id"

  end
end
