# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputRace
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputRace do
          key :required, [:description, :race_id, :name, :faction_id]
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
          property :faction_id do
            key :type, :integer
            key :format, :int64
            key :description, "Faction ID"
          end
          key :example, description: "Once a thriving tribal civilization, the Minmatar...",
                        race_id: 2,
                        name: "Minmatar",
                        faction_id: 500_002
        end
        # :nocov:
      end
    end
  end
end
