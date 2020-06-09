# frozen_string_literal: true

module Api
  module Docs
    module Models
      module Eve
        class OutputRace
          # :nocov:
          include Swagger::Blocks

          swagger_schema :OutputRace do
            key :required, [:faction_id, :description, :name, :race_id]
            property :faction_id do
              key :type, :integer
              key :format, :int64
              key :description, "Faction ID"
            end
            property :description do
              key :type, :string
              key :description, "Race description"
            end
            property :name do
              key :type, :string
              key :description, "Race name"
            end
            property :race_id do
              key :type, :integer
              key :format, :int64
              key :description, "Race ID"
            end
            key :example, faction_id: 500_002,
                          description: "Once a thriving tribal civilization, the Minmatar...",
                          name: "Minmatar",
                          race_id: 2
          end
          # :nocov:
        end
      end
    end
  end
end
