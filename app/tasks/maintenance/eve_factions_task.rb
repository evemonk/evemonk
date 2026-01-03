# frozen_string_literal: true

module Maintenance
  # Import EVE Factions from ESI.
  #
  # 7 Calls to ESI.
  class EveFactionsTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateFactionsJob.perform_later
    end
  end
end
