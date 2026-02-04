# frozen_string_literal: true

module Maintenance
  class EveLocalCharactersTask < MaintenanceTasks::Task
    no_collection

    def process
      Eve::LocalCharactersJob.perform_later
    end
  end
end
