module Api
  module Docs
    module Models
      class User
        # :nocov:
        include Swagger::Blocks

        swagger_schema :User do
          key :required, [:id, :email, :token]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, 'User ID. e.g. "42"'
          end
          property :email do
            key :type, :string
            key :description, 'User email'
          end
          property :token do
            key :type, :string
            key :description, 'User auth token'
          end
        end
        # :nocov:
      end
    end
  end
end
