# frozen_string_literal: true

module Maintenance
  # Reindex all alliances in Meilisearch.
  #
  # Fast.
  class MeilisearchReindexAlliancesTask < MaintenanceTasks::Task
    def collection
      Eve::Alliance.in_batches(batch_size: 100)
    end

    # alliance [Eve::Alliance] The alliance to reindex.
    def process(alliance)
      Meilisearch::Rails::MSJob.perform_later(alliance, :index!)
    end
  end
end
