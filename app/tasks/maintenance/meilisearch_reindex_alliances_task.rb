# frozen_string_literal: true

module Maintenance
  # Reindex all alliances in Meilisearch.
  #
  # Fast.
  class MeilisearchReindexAlliancesTask < MaintenanceTasks::Task
    collection_batch_size(100)

    def collection
      Eve::Alliance.all
    end

    # @param alliance [Eve::Alliance] The alliance to reindex.
    def process(alliance)
      Meilisearch::Eve::ReindexAllianceJob.perform_later(alliance.id, false)
    end
  end
end
