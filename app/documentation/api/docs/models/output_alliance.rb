# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputAlliance
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputAlliance do
          key :required, [:alliance_id, :name, :ticker, :creator_id,
            :creator_corporation_id, :executor_corporation_id, :date_founded,
            :faction_id]
          property :alliance_id do
            key :type, :integer
            key :format, :int64
            key :description, "Alliance ID"
          end
          property :name do
            key :type, :string
            key :description, "Alliance name"
          end
          property :ticker do
            key :type, :string
          end
          property :creator_id do
            key :type, :integer
            key :format, :int64
          end
          property :creator_corporation_id do
            key :type, :integer
            key :format, :int64
          end
          property :executor_corporation_id do
            key :type, :integer
            key :format, :int64
          end
          property :date_founded do
            key :type, :string
          end
          property :faction_id do
            key :type, :integer
            key :format, :int64
          end
          key :example, alliance_id: 99_005_443,
                        name: "Kids With Guns Alliance",
                        ticker: "-KWG-",
                        creator_id: 94_195_096,
                        creator_corporation_id: 98_306_624,
                        executor_corporation_id: 98_306_624,
                        date_founded: "2015-05-03T19:45:17Z",
                        faction_id: 500_001
        end
        # :nocov:
      end
    end
  end
end
