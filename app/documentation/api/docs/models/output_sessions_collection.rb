# frozen_string_literal: true

module Api
  module Docs
    module Models
      class OutputSessionsCollection
        # :nocov:
        include Swagger::Blocks

        swagger_schema :OutputSessionsCollection do
          key :required, [:collection, :total_pages, :current_page,
            :total_entries]
          property :collection do
            key :type, :array
            items do
              key :'$ref', :OutputSessionWithoutToken
            end
          end
          property :total_pages do
            key :type, :integer
            key :format, :int64
            key :description, "Total pages count"
          end
          property :current_page do
            key :type, :integer
            key :format, :int64
            key :description, "Current page number"
          end
          property :total_entries do
            key :type, :integer
            key :format, :int64
            key :description, "Total entries"
          end
          key :example,
            collection: [{id: 123,
                          name: "My Computer",
                          created_at: "2016-12-12T18:35:59Z",
                          updated_at: "2016-12-12T18:36:10Z"}],
            total_pages: 4,
            current_page: 1,
            total_entries: 90
        end
        # :nocov:
      end
    end
  end
end
