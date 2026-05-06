# frozen_string_literal: true

module Meilisearch
  module Eve
    class ReindexCharacterJob < ApplicationJob
      queue_as :meilisearch

      # @param id [Integer] The ID of the Eve::Character to reindex
      # @param remove [Boolean] Whether to remove the character from the index instead of reindexing it
      def perform(id, remove)
        if remove
          Eve::Character.index.delete_document(id)
        else
          Eve::Character.find(id).index!
        end
      end
    end
  end
end
