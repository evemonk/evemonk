module Api
  module Docs
    class Sessions
      # :nocov:
      include Swagger::Blocks

      swagger_path '/sessions' do
        operation :get do
          key :summary, 'Get all user sessions'
          key :description, 'Get all user sessions'
          key :tags, ['sessions']
          parameter :authorization
          parameter :page

          response '200' do
            key :description, 'Success'
            schema do
              key :'$ref', :OutputSessionWithoutToken
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
