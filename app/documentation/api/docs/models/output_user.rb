module Api
  module Docs
    module Models
      class OutputUser
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputUser do
          key :required, [:id, :email, :created_at, :updated_at]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, 'User ID'
          end
          property :email do
            key :type, :string
            key :description, 'User email'
          end
          property :created_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Created at in ISO8601 format'
          end
          property :updated_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Updated at in ISO8601 format'
          end
          key :example, id: 42,
                        email: 'me@example.com',
                        created_at: Time.zone.now.iso8601,
                        updated_at: Time.zone.now.iso8601
        end
        # :nocov:
      end
    end
  end
end
