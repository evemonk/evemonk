# frozen_string_literal: true

module Eve
  class TypesImporter
    attr_reader :page, :esi

    def initialize(page = 1)
      @page = page
      @esi = EveOnline::ESI::UniverseTypes.new(page: @page)
    end

    def import
      ActiveRecord::Base.transaction do
        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        import_types

        import_other_pages

        etag.update!(etag: esi.etag)
      end
    end

    private

    def import_types
      esi.universe_type_ids.each do |type_id|
        if !Eve::Type.exists?(type_id: type_id)
          Eve::TypeImporterWorker.perform_async(type_id)
        end
      end
    end

    def import_other_pages
      return if page != 1 || esi.total_pages == 1

      (2..esi.total_pages).each do |next_page|
        Eve::TypesImporterWorker.perform_async(next_page)
      end
    end
  end
end
