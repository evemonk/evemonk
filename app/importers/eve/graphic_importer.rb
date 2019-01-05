# frozen_string_literal: true

module Eve
  class GraphicImporter
    attr_reader :graphic_id

    def initialize(graphic_id)
      @graphic_id = graphic_id
    end

    def import
      eve_graphic = Eve::Graphic.find_or_initialize_by(graphic_id: graphic_id)

      eveonline_esi_graphic = EveOnline::ESI::UniverseGraphic.new(id: graphic_id)

      etag = Etag.find_or_initialize_by(url: eveonline_esi_graphic.url)

      eveonline_esi_graphic.etag = etag.etag

      return if eveonline_esi_graphic.not_modified?

      eve_graphic.update!(eveonline_esi_graphic.as_json)

      etag.update!(etag: eveonline_esi_graphic.etag)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_graphic.destroy!
    end
  end
end
