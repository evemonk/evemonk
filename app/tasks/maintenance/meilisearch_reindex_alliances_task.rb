# frozen_string_literal: true

module Maintenance
  # Reindex all alliances in Meilisearch.
  #
  # Fast.
  class MeilisearchReindexAlliancesTask < MaintenanceTasks::Task
    def collection
      Eve::Alliance.in_batches(batch_size: 100)
    end

    # @param alliance [Eve::Alliance] The alliance to reindex.
    def process(alliance)
      Meilisearch::ReindexAllianceJob.perform_later(alliance.id, false)
    end
  end
end
