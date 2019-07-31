# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputSession
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputSession do
          key :required, [:id, :token, :name, :device_type, :device_token,
                          :created_at, :updated_at,]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, "Session ID"
          end
          property :token do
            key :type, :string
            key :description, "Session token"
          end
          property :name do
            key :type, :string
            key :description, "Session name"
          end
          property :device_type do
            key :type, :string
            key :description, "Session device type"
            key :enum, Session.device_types.keys
          end
          property :device_token do
            key :type, :string
            key :description, "Session device push notification token"
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
          key :example, id: 123,
                        token: "AAkoMiLatQHMngyuUU1vnh5b",
                        name: "My Computer",
                        device_type: "ios",
                        device_token: "ce8be6272e43e85516033e24b4c289220eeda4879c477160b2545e95b68b5969",
                        created_at: "2016-12-12T18:35:59Z",
                        updated_at: "2016-12-12T18:36:10Z"
        end
        # :nocov:
      end
    end
  end
end
