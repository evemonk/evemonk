# frozen_string_literal: true

module Api
  module Docs
    class SignOuts
      # :nocov:
      include Swagger::Blocks

      swagger_path "/sign_out" do
        operation :delete do
          key :summary, "Sign out"
          key :description, "Sign out user"
          key :tags, ["sign out"]
          parameter :authorization
          response "204" do
            key :description, "Success"
          end
          extend Api::Docs::Shared::Unauthorized
          extend Api::Docs::Shared::NotAcceptable
        end
      end
      # :nocov:
    end
  end
end
