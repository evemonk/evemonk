module Api
  module Docs
    module Models
      class OutputSessionsCollection
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputSessionsCollection do
          key :required, [:collection, :total_pages, :current_page]
          property :collection do
            key :type, :array
            items do
              key :'$ref', :OutputSessionWithoutToken
            end
          end
          property :total_pages do
            key :type, :integer
            key :format, :int64
            key :description, 'Total pages count'
          end
          property :current_page do
            key :type, :integer
            key :format, :int64
            key :description, 'Current page number'
          end
        end
        # :nocov:
      end
    end
  end
end
