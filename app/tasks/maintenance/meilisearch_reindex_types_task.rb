# frozen_string_literal: true

module Maintenance
  # Reindex all types in Meilisearch.
  #
  # Slow.
  class MeilisearchReindexTypesTask < MaintenanceTasks::Task
    def collection
      Eve::Type.in_batches(batch_size: 100)
    end

    # @param type [Eve::Type] The type to reindex.
    def process(type)
      Meilisearch::Eve::ReindexTypeJob.perform_later(type.id, false)
    end
  end
end
