# frozen_string_literal: true

module Maintenance
  # Reindex all Meilisearch indexes.
  #
  # Few minutes to run, depending on the number of records in the database.
  class MeilisearchReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Alliance.clear_index!
      Eve::Alliance.reindex!

      Eve::Corporation.clear_index!
      Eve::Corporation.reindex!

      Eve::Character.clear_index!
      Eve::Character.reindex!

      Eve::Type.clear_index!
      Eve::Type.reindex!
    end
  end
end
