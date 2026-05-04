# frozen_string_literal: true

module Maintenance
  # Reindex all alliances in Meilisearch.
  #
  # Fast.
  class MeilisearchReindexAlliancesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Alliance.clear_index!

      Eve::Alliance.reindex!(100)
    end
  end
end
