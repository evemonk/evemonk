# frozen_string_literal: true

module Maintenance
  # Reindex all characters in Meilisearch.
  #
  # Very slow.
  class MeilisearchReindexCharactersTask < MaintenanceTasks::Task
    collection_batch_size(100)

    def collection
      Eve::Character.all
    end

    # @param character [Eve::Character] The character to reindex.
    def process(character)
      Meilisearch::Eve::ReindexCharacterJob.perform_later(character.id, false)
    end
  end
end
