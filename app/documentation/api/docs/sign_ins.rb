# frozen_string_literal: true

module Api
  module Docs
    class SignIns
      # :nocov:
      include Swagger::Blocks

      swagger_path "/sign_in" do
        operation :post do
          key :summary, "Sign in"
          key :description, "Sign in user"
          key :tags, ["sign in"]
          parameter do
            key :name, "sign_in[email]"
            key :in, :formData
            key :required, true
            key :type, :string
            key :description, "User email"
          end
          parameter do
            key :name, "sign_in[password]"
            key :in, :formData
            key :required, true
            key :type, :string
            key :format, :password
            key :description, "User password"
          end
          parameter do
            key :name, "sign_in[name]"
            key :in, :formData
            key :required, false
            key :type, :string
            key :format, :password
            key :description, "Session name"
          end
          parameter do
            key :name, "sign_in[device_type]"
            key :in, :formData
            key :required, false
            key :type, :string
            key :enum, Session.device_types.keys
            key :description, "Device type"
          end
          parameter do
            key :name, "sign_in[device_token]"
            key :in, :formData
            key :required, false
            key :type, :string
            key :description, "Device token"
          end
          response "200" do
            key :description, "Success"
            schema do
              key :'$ref', :OutputSession
            end
          end
          response "422" do
            key :description, "Unprocessable Entity"
            schema do
              key :'$ref', :SignInsUnprocessableEntity
            end
          end
          extend Api::Docs::Shared::NotAcceptable
        end
      end
      # :nocov:
    end
  end
end
