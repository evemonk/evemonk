# frozen_string_literal: true

module Eve
  class LocalAlliancesImporter
    def import
      Eve::Alliance.ids.each do |id|
        Eve::UpdateAllianceJob.perform_later(id)
      end
    end
  end
end
