# frozen_string_literal: true

module Maintenance
  # Reindex all alliances in Meilisearch.
  #
  # Fast.
  class MeilisearchReindexAlliancesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::Alliance.clear_index!

      Eve::Alliance.find_each(batch_size: 100).each do |alliance|
        Meilisearch::Rails::MSJob.perform_later(alliance, :index!)
      end
    end
  end
end
