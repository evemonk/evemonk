module Api
  module Docs
    class Signups
      # :nocov:
      include Swagger::Blocks

      swagger_path '/signups' do
        operation :post do
          key :description, 'Signup'
          key :tags, ['signups']
          parameter do
            key :name, 'user[email]'
            key :in, :formData
            key :description, 'User email'
            key :required, true
            key :type, :string
          end
          parameter do
            key :name, 'user[password]'
            key :in, :formData
            key :description, 'User password'
            key :required, true
            key :type, :string
            key :format, :password
          end
          parameter do
            key :name, 'user[password_confirmation]'
            key :in, :formData
            key :description, 'User password confirmation'
            key :required, true
            key :type, :string
            key :format, :password
          end
          response 200 do
            key :description, 'Account created'
            schema do
              key :'$ref', :OutputUser
            end
          end
        end
      end
      # :nocov:
    end
  end
end
