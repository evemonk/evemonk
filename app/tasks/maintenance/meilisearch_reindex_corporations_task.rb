# frozen_string_literal: true

module Maintenance
  # Reindex all corporations in Meilisearch.
  #
  # Very slow.
  class MeilisearchReindexCorporationsTask < MaintenanceTasks::Task
    collection_batch_size(100)

    def collection
      Eve::Corporation.all
    end

    # @param corporation [Eve::Corporation] The corporation to reindex.
    def process(corporation)
      Meilisearch::Eve::ReindexCorporationJob.perform_later(corporation.id, false)
    end
  end
end
