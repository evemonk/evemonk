# frozen_string_literal: true

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
            key :description, "User ID"
          end
          property :email do
            key :type, :string
            key :description, "User email"
          end
          property :created_at do
            key :type, :string
            key :format, :'date-time'
            key :description, "Created at in ISO8601 format"
          end
          property :updated_at do
            key :type, :string
            key :format, :'date-time'
            key :description, "Updated at in ISO8601 format"
          end
          key :example, id: 42,
                        email: "me@example.com",
                        created_at: "2016-12-12T18:35:59Z",
                        updated_at: "2016-12-12T18:36:10Z"
        end
        # :nocov:
      end
    end
  end
end
