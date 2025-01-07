# frozen_string_literal: true

module Maintenance
  # Import EVE Races from ESI.
  #
  # 7 Calls to ESI.
  class EveRacesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateRacesJob.perform_later
    end
  end
end
