# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Character records.
  class EveCharactersReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Character.reindex!
    end
  end
end
