# frozen_string_literal: true

module Maintenance
  # Reindex all characters in Meilisearch.
  #
  # Very slow.
  class MeilisearchReindexCharactersTask < MaintenanceTasks::Task
    def collection
      Eve::Character.in_batches(batch_size: 100)
    end

    # @param character [Eve::Character] The character to reindex.
    def process(character)
      Meilisearch::Eve::ReindexCharacterJob.perform_later(character.id, false)
    end
  end
end
