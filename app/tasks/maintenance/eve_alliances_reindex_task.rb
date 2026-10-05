# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Alliance records.
  class EveAlliancesReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      ActiveSearch.index(:eve_alliances).batch(max_size: 500) do |batch|
        Eve::Alliance.find_each { |alliance| batch.add(alliance) }
      end
    end
  end
end
