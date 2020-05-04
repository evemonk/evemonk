# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputBloodline
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputBloodline do
          key :required, [:bloodline_id, :name, :description, :race_id,
            :ship_type_id, :corporation_id, :perception, :willpower,
            :charisma, :memory, :intelligence]
          property :bloodline_id do
            key :type, :integer
            key :format, :int64
            key :description, "Bloodline ID"
          end
          property :name do
            key :type, :string
            key :description, "Bloodline name"
          end
          property :description do
            key :type, :string
            key :description, "Bloodline description"
          end
          property :race_id do
            key :type, :integer
            key :format, :int64
            key :description, "Race ID"
          end
          property :ship_type_id do
            key :type, :integer
            key :format, :int64
          end
          property :corporation_id do
            key :type, :integer
            key :format, :int64
          end
          property :perception do
            key :type, :integer
            key :format, :int64
          end
          property :willpower do
            key :type, :integer
            key :format, :int64
          end
          property :charisma do
            key :type, :integer
            key :format, :int64
          end
          property :memory do
            key :type, :integer
            key :format, :int64
          end
          property :intelligence do
            key :type, :integer
            key :format, :int64
          end
          key :example, bloodline_id: 4,
                        name: "Brutor",
                        description: "A martial, strong-willed people, the Brutor...",
                        race_id: 2,
                        ship_type_id: 588,
                        corporation_id: 1_000_049,
                        perception: 9,
                        willpower: 7,
                        charisma: 6,
                        memory: 4,
                        intelligence: 4
        end
        # :nocov:
      end
    end
  end
end
