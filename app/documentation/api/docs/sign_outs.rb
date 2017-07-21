module Api
  module Docs
    class SignOuts
      # :nocov:
      include Swagger::Blocks

      swagger_path '/sign_out' do
        operation :delete do
          key :summary, 'Sign out'
          key :description, 'Sign out user'
          key :tags, ['sign out']
          parameter :authorization
          response '200' do
            key :description, 'Success'
          end
          extend Api::Docs::Shared::Unauthorized
        end
      end
      # :nocov:
    end
  end
end
