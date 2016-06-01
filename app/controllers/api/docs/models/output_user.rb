# :nocov:
module Api
  module Docs
    module Models
      class OutputUser
        include Swagger::Blocks

        swagger_schema :OutputUser do
          key :required, [:id, :email, :token]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, 'User ID. e.g. "42"'
          end
          property :email do
            key :type, :string
            key :description, 'User email. e.g. "me@example.com"'
          end
          property :token do
            key :type, :string
            key :description, 'User auth token. e.g. "AAkoMiLatQHMngyuUU1vnh5b"'
          end
        end
      end
    end
  end
end
# :nocov:
