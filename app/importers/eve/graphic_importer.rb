# frozen_string_literal: true

module Eve
  class GraphicImporter
    attr_reader :graphic_id

    def initialize(graphic_id)
      @graphic_id = graphic_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_graphic = Eve::Graphic.find_or_initialize_by(graphic_id: graphic_id)

        esi = EveOnline::ESI::UniverseGraphic.new(id: graphic_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_graphic.update!(esi.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_graphic.destroy!
      end
    end
  end
end
