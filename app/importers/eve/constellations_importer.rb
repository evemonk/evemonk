# frozen_string_literal: true

module Eve
  class ConstellationsImporter < BaseImporter
    def import
      import! do
        import_new_constellations

        remove_old_constellations
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseConstellations.new
    end

    private

    def import_new_constellations
      eve_constellation_ids = Eve::Constellation.pluck(:id)

      eve_constellation_ids_to_create = esi.constellation_ids - eve_constellation_ids

      eve_constellation_ids_to_create.each do |constellation_id|
        Eve::UpdateConstellationJob.perform_later(constellation_id)
      end
    end

    def remove_old_constellations
      eve_constellation_ids = Eve::Constellation.pluck(:id)

      eve_constellation_ids_to_remove = eve_constellation_ids - esi.constellation_ids

      eve_constellation_ids_to_remove.each do |constellation_id|
        eve_constellation = Eve::Constellation.find_or_initialize_by(id: constellation_id)

        eve_constellation.destroy!
      end
    end
  end
end
