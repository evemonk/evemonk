# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Type records.
  class EveTypesReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Type.reindex!
    end
  end
end
