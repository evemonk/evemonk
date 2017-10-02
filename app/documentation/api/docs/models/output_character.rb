module Api
  module Docs
    module Models
      class OutputCharacter
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputCharacter do
          key :required, [:id, :uid, :name, :created_at, :updated_at]
          property :id do
            key :type, :integer
            key :format, :int64
            key :description, 'Character ID'
          end
          property :uid do
            key :type, :integer
            key :format, :int64
            key :description, 'Character UID'
          end
          property :name do
            key :type, :string
            key :description, 'Character name'
          end
          property :created_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Created at in ISO8601 format'
          end
          property :updated_at do
            key :type, :string
            key :format, :'date-time'
            key :description, 'Updated at in ISO8601 format'
          end
          key :example, id: 123,
                        uid: 1337512245,
                        name: 'Johnn Dillinger',
                        created_at: '2016-12-12T18:35:59Z',
                        updated_at: '2016-12-12T18:36:10Z'
        end
        # :nocov:
      end
    end
  end
end
