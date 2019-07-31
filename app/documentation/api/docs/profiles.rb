# frozen_string_literal: true

module Api
  module Docs
    class Profiles
      # :nocov:
      include Swagger::Blocks

      swagger_path "/profile" do
        operation :get do
          key :summary, "Get current user profile"
          key :description, "Get current user profile"
          key :tags, ["profile"]
          parameter :authorization
          response "200" do
            key :description, "Success"
            schema do
              key :'$ref', :OutputUser
            end
          end
          extend Api::Docs::Shared::Unauthorized
          extend Api::Docs::Shared::NotAcceptable
        end
      end
      # :nocov:
    end
  end
end
