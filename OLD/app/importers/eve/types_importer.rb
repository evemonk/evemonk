# frozen_string_literal: true

module Eve
  class TypesImporter
    attr_reader :page

    def initialize(page)
      @page = page
    end

    def import
      eveonline_esi_types = EveOnline::ESI::UniverseTypes.new

      etag = Etag.find_or_initialize_by(url: eveonline_esi_types.url)

      eveonline_esi_types.etag = etag.etag

      return if eveonline_esi_types.not_modified?

      eveonline_esi_types.universe_type_ids.each do |type_id|
        Eve::TypeImporterWorker.perform_async(type_id)
      end

      etag.update!(etag: eveonline_esi_types.etag)
    end
  end
end
