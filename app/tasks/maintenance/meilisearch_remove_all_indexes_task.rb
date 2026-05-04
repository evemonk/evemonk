# frozen_string_literal: true

module Maintenance
  # Clear all indexes from Meilisearch.
  #
  # Fast.
  class MeilisearchRemoveAllIndexesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Alliance.clear_index!

      Eve::Corporation.clear_index!

      Eve::Character.clear_index!

      Eve::Type.clear_index!
    end
  end
end
