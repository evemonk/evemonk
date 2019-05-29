# frozen_string_literal: true

module Eve
  class TypesImporter
    attr_reader :page

    def initialize(page)
      @page = page
    end

    def import
      esi = EveOnline::ESI::UniverseTypes.new

      etag = Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      esi.universe_type_ids.each do |type_id|
        Eve::TypeImporterWorker.perform_async(type_id)
      end

      etag.update!(etag: esi.etag)
    end
  end
end
