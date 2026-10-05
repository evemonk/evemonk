# frozen_string_literal: true

module Maintenance
  # Force reindexing of Eve::Character records.
  class EveCharactersReindexTask < MaintenanceTasks::Task
    no_collection

    def process
      ActiveSearch.index(:eve_characters).batch(max_size: 500) do |batch|
        Eve::Character.find_each { |character| batch.add(character) }
      end
    end
  end
end
