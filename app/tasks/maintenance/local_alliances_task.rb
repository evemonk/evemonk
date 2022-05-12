# frozen_string_literal: true

module Maintenance
  class LocalAlliancesTask < MaintenanceTasks::Task
    delegate :count, to: :collection

    def collection
      Eve::Alliance.all
    end

    def process(alliance)
      Eve::AllianceImporter.new(alliance.alliance_id).import
    end
  end
end
