# frozen_string_literal: true

module Maintenance
  # Reindex all corporations in Meilisearch.
  #
  # Very slow.
  class MeilisearchReindexCorporationsTask < MaintenanceTasks::Task
    def collection
      Eve::Corporation.in_batches(batch_size: 100)
    end

    # @param corporation [Eve::Corporation] The corporation to reindex.
    def process(corporation)
      Meilisearch::Eve::ReindexCorporationJob.perform_later(corporation.id, false)
    end
  end
end
