# frozen_string_literal: true

module Maintenance
  # Reindex all corporations in Meilisearch.
  #
  # Very slow.
  class MeilisearchReindexCorporationsTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Corporation.clear_index!

      Eve::Corporation.reindex!(100)
    end
  end
end
