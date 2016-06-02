# :nocov:
module Api
  module Docs
    class Sessions
      include Swagger::Blocks

      swagger_path '/sessions' do
        operation :post do
          key :description, 'Get user auth token'
          key :tags, ['sessions']
          parameter do
            key :name, 'session[email]'
            key :in, :formData
            key :description, 'User email'
            key :required, true
            key :type, :string
          end
          parameter do
            key :name, 'session[password]'
            key :in, :formData
            key :description, 'User password'
            key :required, true
            key :type, :string
            key :format, :password
          end
          response 200 do
            key :description, 'Response with User model with token'
            schema do
              key :'$ref', :OutputUser
            end
          end
        end
      end
    end
  end
end
# :nocov:
