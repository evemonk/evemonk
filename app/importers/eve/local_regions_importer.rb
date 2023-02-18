# frozen_string_literal: true

module Eve
  class LocalRegionsImporter
    def import
      Eve::Region.pluck(:id).each do |region_id|
        Eve::UpdateRegionJob.perform_later(region_id)
      end
    end
  end
end
