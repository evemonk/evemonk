# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Type records.
  class EveTypesReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      ActiveSearch.index(:eve_types).batch(max_size: 500) do |batch|
        Eve::Type.find_each { |type| batch.add(type) }
      end
    end
  end
end
