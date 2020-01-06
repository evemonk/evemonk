# frozen_string_literal: true

module Eve
  class LocalConstellationsImporter
    def import
      Eve::Constellation.pluck(:constellation_id).each do |constellation_id|
        Eve::UpdateConstellationJob.perform_later(constellation_id)
      end
    end
  end
end
