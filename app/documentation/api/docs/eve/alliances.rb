# frozen_string_literal: true

module Api
  module Docs
    module Eve
      class Alliances
        # :nocov:
        include Swagger::Blocks

        swagger_path '/eve/alliances' do
          operation :get do
            key :summary, 'Get all eve alliances'
            key :description, 'Get all eve alliances'
            key :tags, ['eve_alliances']
            parameter :page
            response '200' do
              key :description, 'Success'
              schema do
                key :'$ref', :OutputEveAlliancesCollection
              end
            end
            extend Api::Docs::Shared::NotAcceptable
          end
        end


        # :nocov:
      end
    end
  end
end
