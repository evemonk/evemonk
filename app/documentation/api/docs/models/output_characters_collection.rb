module Api
  module Docs
    module Models
      class OutputCharactersCollection
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputCharactersCollection do
          key :required, [:collection, :total_pages, :current_page,
                          :total_entries]
          property :collection do
            key :type, :array
            items do
              key :'$ref', :OutputCharacter
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
          property :total_entries do
            key :type, :integer
            key :format, :int64
            key :description, 'Total entries'
          end
        end
        # :nocov:
      end
    end
  end
end
