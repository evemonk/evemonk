# frozen_string_literal: true

module Maintenance
  class EveFactionsTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateFactionsJob.perform_later
    end
  end
end
