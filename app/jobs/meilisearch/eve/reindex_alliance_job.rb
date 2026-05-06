# frozen_string_literal: true

module Meilisearch
  module Eve
    class ReindexAllianceJob < ApplicationJob
      queue_as :meilisearch

      # @param id [Integer] The ID of the Eve::Alliance to reindex
      # @param remove [Boolean] Whether to remove the alliance from the index instead of reindexing it
      def perform(id, remove)
        if remove
          ::Eve::Alliance.index.delete_document(id)
        else
          ::Eve::Alliance.find(id).index!
        end
      end
    end
  end
end
