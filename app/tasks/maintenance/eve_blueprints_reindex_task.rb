# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Blueprint records.
  class EveBlueprintsReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Blueprint.reindex!
    end
  end
end
