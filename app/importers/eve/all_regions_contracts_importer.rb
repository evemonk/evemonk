# frozen_string_literal: true

module Eve
  class AllRegionsContractsImporter
    def import
      region_ids.each do |region_id|
        Eve::RegionContractsJob.perform_later(region_id)
      end
    end

    private

    def region_ids
      @region_ids ||= Eve::Region.pluck(:region_id).sort.uniq
    end
  end
end
