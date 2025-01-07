# frozen_string_literal: true

module Maintenance
  class EveAncestriesTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::UpdateAncestriesJob.perform_later
    end
  end
end
