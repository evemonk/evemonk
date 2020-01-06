# frozen_string_literal: true

module Eve
  class ConstellationsImporter
    attr_reader :esi

    def initialize
      @esi = EveOnline::ESI::UniverseConstellations.new
    end

    def import
      ActiveRecord::Base.transaction do
        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        import_new_constellations

        remove_old_constellations

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    private

    def import_new_constellations
      eve_constellation_ids = Eve::Constellation.pluck(:constellation_id)

      eve_constellation_ids_to_create = esi.constellation_ids - eve_constellation_ids

      eve_constellation_ids_to_create.each do |constellation_id|
        Eve::UpdateConstellationJob.perform_later(constellation_id)
      end
    end

    def remove_old_constellations
      eve_constellation_ids = Eve::Constellation.pluck(:constellation_id)

      eve_constellation_ids_to_remove = eve_constellation_ids - esi.constellation_ids

      eve_constellation_ids_to_remove.each do |constellation_id|
        eve_constellation = Eve::Constellation.find_or_initialize_by(constellation_id: constellation_id)

        eve_constellation.destroy!
      end
    end
  end
end
