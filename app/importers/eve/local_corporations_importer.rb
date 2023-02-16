# frozen_string_literal: true

module Eve
  class LocalCorporationsImporter
    def import
      Eve::Corporation.ids.each do |id|
        Eve::UpdateCorporationJob.perform_later(id)
      end
    end
  end
end
