# frozen_string_literal: true

module Eve
  class AllRegionsContractsImporter
    def import
      region_ids.each do |id|
        Eve::RegionContractsJob.perform_later(id)
      end
    end

    private

    def region_ids
      @region_ids ||= Eve::Region.ids
    end
  end
end
