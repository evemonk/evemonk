# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Corporation's.
  class EveCorporationsReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Corporation.reindex!
    end
  end
end
