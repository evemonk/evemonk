# frozen_string_literal: true

module Api
  module Docs
    class Sessions
      # :nocov:
      include Swagger::Blocks

      swagger_path "/sessions/{id}" do
        operation :delete do
          key :summary, "End session"
          key :description, "End session"
          key :tags, ["sessions"]
          parameter :authorization
          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :integer
            key :description, "Session ID"
          end
          response "204" do
            key :description, "Success"
          end
          extend Api::Docs::Shared::Unauthorized
          extend Api::Docs::Shared::NotAcceptable
          extend Api::Docs::Shared::Forbidden
          extend Api::Docs::Shared::NotFound
        end
      end
      # :nocov:
    end
  end
end
