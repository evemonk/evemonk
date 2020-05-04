# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputFaction
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputFaction do
          key :required, [:faction_id, :name, :description, :solar_system_id,
            :corporation_id, :militia_corporation_id, :size_factor,
            :station_count, :station_system_count, :is_unique]
          property :faction_id do
            key :type, :integer
            key :format, :int64
            key :description, "Faction ID"
          end
          property :name do
            key :type, :string
            key :description, "Faction name"
          end
          property :description do
            key :type, :string
            key :description, "Faction description"
          end
          property :solar_system_id do
            key :type, :integer
            key :format, :int64
          end
          property :corporation_id do
            key :type, :integer
            key :format, :int64
          end
          property :militia_corporation_id do
            key :type, :integer
            key :format, :int64
          end
          property :size_factor do
            key :type, :number
            key :format, :float
          end
          property :station_count do
            key :type, :integer
            key :format, :int64
          end
          property :station_system_count do
            key :type, :integer
            key :format, :int64
          end
          property :is_unique do
            key :type, :integer
            key :format, :int64
          end
          key :example, faction_id: 500_002,
                        name: "Minmatar Republic",
                        description: "The Minmatar Republic was formed over a century ago when the Minmatar threw...",
                        solar_system_id: 30_002_544,
                        corporation_id: 1_000_051,
                        militia_corporation_id: 1_000_182,
                        size_factor: 5.0,
                        station_count: 570,
                        station_system_count: 291,
                        is_unique: true
        end
        # :nocov:
      end
    end
  end
end
