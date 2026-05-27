# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Alliance's.
  class EveAlliancesReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Alliance.reindex!
    end
  end
end
