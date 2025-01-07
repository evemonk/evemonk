# frozen_string_literal: true

module Maintenance
  # Import EVE Bloodlines from ESI.
  #
  # 7 Calls to ESI.
  class EveBloodlinesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateBloodlinesJob.perform_later
    end
  end
end
