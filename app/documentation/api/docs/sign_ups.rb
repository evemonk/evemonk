# frozen_string_literal: true

module Api
  module Docs
    class SignUps
      # :nocov:
      include Swagger::Blocks

      swagger_path "/sign_up" do
        operation :post do
          key :summary, "Sign up"
          key :description, "Sign up new user."
          key :tags, ["sign up"]
          parameter do
            key :name, "sign_up[email]"
            key :in, :formData
            key :required, true
            key :type, :string
            key :description, "User email"
          end
          parameter do
            key :name, "sign_up[password]"
            key :in, :formData
            key :required, true
            key :type, :string
            key :format, :password
            key :description, "User password"
          end
          parameter do
            key :name, "sign_up[password_confirmation]"
            key :in, :formData
            key :required, true
            key :type, :string
            key :format, :password
            key :description, "User password confirmation"
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
              key :'$ref', :SignUpsUnprocessableEntity
            end
          end
          extend Api::Docs::Shared::NotAcceptable
        end
      end
      # :nocov:
    end
  end
end
