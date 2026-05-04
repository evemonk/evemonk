# frozen_string_literal: true

module Maintenance
  # Reindex all characters in Meilisearch.
  #
  # Very slow.
  class MeilisearchReindexCharactersTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Character.clear_index!

      Eve::Character.reindex!(100)
    end
  end
end
