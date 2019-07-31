# frozen_string_literal: true

module Api
  module Docs
    class Characters
      # :nocov:
      include Swagger::Blocks

      swagger_path "/characters" do
        operation :get do
          key :summary, "Get all user characters"
          key :description, "Get all user characters"
          key :tags, ["characters"]
          parameter :authorization
          parameter :page
          response "200" do
            key :description, "Success"
            schema do
              key :'$ref', :OutputCharactersCollection
            end
          end
          extend Api::Docs::Shared::Unauthorized
          extend Api::Docs::Shared::NotAcceptable
        end
      end

      swagger_path "/characters/{id}" do
        operation :get do
          key :summary, "Get character by ID"
          key :description, "Get character by ID"
          key :tags, ["characters"]
          parameter :authorization
          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :integer
            key :description, "Character ID"
          end
          response "200" do
            key :description, "Success"
            schema do
              key :'$ref', :OutputCharacter
            end
          end
          extend Api::Docs::Shared::Unauthorized
          extend Api::Docs::Shared::NotAcceptable
          extend Api::Docs::Shared::Forbidden
          extend Api::Docs::Shared::NotFound
        end

        operation :delete do
          key :summary, "Remove character by ID"
          key :description, "Remove character by ID"
          key :tags, ["characters"]
          parameter :authorization
          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :integer
            key :description, "Character ID"
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
