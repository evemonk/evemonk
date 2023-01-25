# frozen_string_literal: true

module Eve
  class TypesImporter < BaseImporter
    attr_reader :page

    def initialize(page = 1)
      @page = page
    end

    def import
      import! do
        import_types

        import_other_pages
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseTypes.new(page: page)
    end

    private

    def import_types
      esi.universe_type_ids.each do |type_id|
        unless Eve::Type.exists?(type_id: type_id)
          Eve::UpdateTypeJob.perform_later(type_id)
        end
      end
    end

    def import_other_pages
      return if page != 1 || esi.total_pages == 1

      (2..esi.total_pages).each do |next_page|
        Eve::UpdateTypesJob.perform_later(next_page)
      end
    end
  end
end
