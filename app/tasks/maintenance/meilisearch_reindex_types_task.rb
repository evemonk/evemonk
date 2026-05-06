# frozen_string_literal: true

module Maintenance
  # Reindex all types in Meilisearch.
  #
  # Slow.
  class MeilisearchReindexTypesTask < MaintenanceTasks::Task
    collection_batch_size(100)

    def collection
      Eve::Type.all
    end

    # @param type [Eve::Type] The type to reindex.
    def process(type)
      Meilisearch::Eve::ReindexTypeJob.perform_later(type.id, false)
    end
  end
end
