# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputCorporation
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputCorporation do
          key :required, [:corporation_id, :name, :ticker, :member_count,
            :ceo_id, :alliance_id, :description, :tax_rate, :date_founded,
            :creator_id, :corporation_url, :faction_id, :home_station_id,
            :shares]
          property :corporation_id do
            key :type, :integer
            key :format, :int64
            key :description, "Corporation ID"
          end
          property :name do
            key :type, :string
            key :description, "Corporation name"
          end
          property :ticker do
            key :type, :string
            key :description, "Corporation ticker"
          end
          property :member_count do
            key :type, :integer
            key :format, :int64
            key :description, "Corporation member count"
          end
          property :ceo_id do
            key :type, :integer
            key :format, :int64
          end
          property :alliance_id do
            key :type, :integer
            key :format, :int64
          end
          property :description do
            key :type, :string
          end
          property :tax_rate do
            key :type, :string
          end
          property :date_founded do
            key :type, :string
          end
          property :creator_id do
            key :type, :integer
            key :format, :int64
          end
          property :corporation_url do
            key :type, :string
            key :description, "Corporation URL"
          end
          property :faction_id do
            key :type, :integer
            key :format, :int64
          end
          property :home_station_id do
            key :type, :integer
            key :format, :int64
          end
          property :shares do
            key :type, :integer
            key :format, :int64
          end
          key :example, corporation_id: 98_134_807,
                        name: "MyLittleDragon",
                        ticker: "MYLID",
                        member_count: 120,
                        ceo_id: 1_208_274_826,
                        alliance_id: 99_005_443,
                        description: "",
                        tax_rate: "0.09",
                        date_founded: "2012-08-28T20:16:00Z",
                        creator_id: 265_506_411,
                        corporation_url: "http://",
                        faction_id: 500_002,
                        home_station_id: 60_004_474,
                        shares: 1000
        end
        # :nocov:
      end
    end
  end
end
