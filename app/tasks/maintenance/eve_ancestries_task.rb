# frozen_string_literal: true

module Maintenance
  # Import EVE Ancestries from ESI.
  #
  # 7 Calls to ESI.
  class EveAncestriesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateAncestriesJob.perform_later
    end
  end
end
