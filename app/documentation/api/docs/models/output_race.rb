# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputRace
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputRace do
          key :required, [:description, :race_id, :name, :alliance_id]
          property :description do
            key :type, :string
            key :description, "Race description"
          end
          property :race_id do
            key :type, :integer
            key :format, :int64
            key :description, "Race ID"
          end
          property :name do
            key :type, :string
            key :description, "Race name"
          end
          property :alliance_id do
            key :type, :integer
            key :format, :int64
            key :description, "Alliance ID"
          end
          key :example, description: "Once a thriving tribal civilization, the Minmatar...",
                        race_id: 2,
                        name: "Minmatar",
                        alliance_id: 500_002
        end
        # :nocov:
      end
    end
  end
end
