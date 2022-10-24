# frozen_string_literal: true

module Eve
  class AlliancesCorporationsImporter
    def import
      Eve::Alliance.ids.each do |id|
        Eve::UpdateAllianceCorporationsJob.perform_later(id)
      end
    end
  end
end
