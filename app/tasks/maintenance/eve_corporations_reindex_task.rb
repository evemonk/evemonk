# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Corporation records.
  class EveCorporationsReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      ActiveSearch.index(:eve_corporations).batch(max_size: 500) do |batch|
        Eve::Corporation.find_each { |corporation| batch.add(corporation) }
      end
    end
  end
end
