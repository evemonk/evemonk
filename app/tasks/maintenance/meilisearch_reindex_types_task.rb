# frozen_string_literal: true

module Maintenance
  # Reindex all types in Meilisearch.
  #
  # Slow.
  class MeilisearchReindexTypesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Type.clear_index!

      Eve::Type.reindex!(100)
    end
  end
end
