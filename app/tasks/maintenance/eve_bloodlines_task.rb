# frozen_string_literal: true

module Maintenance
  class EveBloodlinesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateBloodlinesJob.perform_later
    end
  end
end
