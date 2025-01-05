# frozen_string_literal: true

module Eve
  class RegionsImporter < BaseImporter
    def import
      import! do
        import_new_regions

        remove_old_regions
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseRegions.new
    end

    private

    def import_new_regions
      eve_region_ids = Eve::Region.pluck(:region_id)

      eve_region_ids_to_create = esi.universe_region_ids - eve_region_ids

      eve_region_ids_to_create.each do |region_id|
        Eve::UpdateRegionJob.perform_later(region_id)
      end
    end

    def remove_old_regions
      eve_region_ids = Eve::Region.pluck(:region_id)

      eve_region_ids_to_remove = eve_region_ids - esi.universe_region_ids

      eve_region_ids_to_remove.each do |region_id|
        eve_region = Eve::Region.find_or_initialize_by(region_id: region_id)

        eve_region.destroy!
      end
    end
  end
end
