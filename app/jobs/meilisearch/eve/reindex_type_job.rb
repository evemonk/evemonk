# frozen_string_literal: true

module Meilisearch
  module Eve
    class ReindexTypeJob < ApplicationJob
      queue_as :meilisearch

      # @param id [Integer] The ID of the Eve::Type to reindex
      # @param remove [Boolean] Whether to remove the type from the index instead of reindexing it
      def perform(id, remove)
        if remove
          Eve::Type.index.delete_document(id)
        else
          Eve::Type.find(id).index!
        end
      end
    end
  end
end
