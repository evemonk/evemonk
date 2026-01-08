# frozen_string_literal: true

module Maintenance
  # Import EVE Alliances from ESI.
  #
  # 3137+ Calls to ESI.
  class EveAlliancesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateAlliancesJob.perform_later
    end
  end
end
