# frozen_string_literal: true

module Meilisearch
  class ReindexCorporationJob < ApplicationJob
    queue_as :meilisearch

    # @param id [Integer] The ID of the Eve::Corporation to reindex
    # @param remove [Boolean] Whether to remove the corporation from the index instead of reindexing it
    def perform(id, remove)
      if remove
        Eve::Corporation.index.delete_document(id)
      else
        Eve::Corporation.find(id).index!
      end
    end
  end
end
