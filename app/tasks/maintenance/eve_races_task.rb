# frozen_string_literal: true

module Maintenance
  class EveRacesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateRacesJob.perform_later
    end
  end
end
