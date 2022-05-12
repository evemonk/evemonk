# frozen_string_literal: true

module Maintenance
  class LocalAlliancesTask < MaintenanceTasks::Task
    def collection
      Eve::Alliance.all
    end

    def process(alliance)
      Eve::AllianceImporter.new(alliance.alliance_id).import
    end

    def count
      collection.count
    end
  end
end
