# frozen_string_literal: true

module Api
  module Docs
    module Models
      class SignUpsUnprocessableEntity
        # :nocov:
        include Swagger::Blocks

        swagger_schema :SignUpsUnprocessableEntity do
          key :required, [:errors]
          property :errors do
            key :type, :array
            items do
              key :type, :string
            end
          end
          key :example,
            errors: {email: [],
                     password: [],
                     password_confirmation: []}
        end
        # :nocov:
      end
    end
  end
end
