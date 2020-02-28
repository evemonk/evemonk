# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputAncestry
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputAncestry do
          key :required, [:ancestry_id, :name, :bloodline_id, :description,
                          :short_description, :icon_id]
          property :ancestry_id do
            key :type, :integer
            key :format, :int64
            key :description, "Ancestry ID"
          end
          property :name do
            key :type, :string
            key :description, "Ancestry name"
          end
          property :bloodline_id do
            key :type, :integer
            key :format, :int64
          end
          property :description do
            key :type, :string
            key :description, "Ancestry description"
          end
          property :short_description do
            key :type, :string
            key :description, "Ancestry short description"
          end
          property :icon_id do
            key :type, :integer
            key :format, :int64
          end
          key :example, ancestry_id: 24,
                        name: "Slave Child",
                        bloodline_id: 4,
                        description: "Millions of slaves within the Amarr Empire dream of escape...",
                        short_description: "Torn from the cold and brought to the warmth of a new life.",
                        icon_id: 1664
        end
        # :nocov:
      end
    end
  end
end
