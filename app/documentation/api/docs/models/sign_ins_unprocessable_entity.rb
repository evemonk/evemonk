# frozen_string_literal: true

module Api
  module Docs
    module Models
      class SignInsUnprocessableEntity
        # :nocov:
        include Swagger::Blocks

        swagger_schema :SignInsUnprocessableEntity do
          key :required, [:errors]
          property :errors do
            key :type, :array
            items do
              key :type, :string
            end
          end
          key :example, errors: {email: [], password: [], base: []}
        end
        # :nocov:
      end
    end
  end
end
