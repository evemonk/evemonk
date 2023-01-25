# frozen_string_literal: true

module Eve
  class GraphicImporter < BaseImporter
    attr_reader :graphic_id

    def initialize(graphic_id)
      @graphic_id = graphic_id
    end

    def import
      import! do
        eve_graphic = Eve::Graphic.find_or_initialize_by(graphic_id: graphic_id)

        eve_graphic.update!(esi.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Graphic ID #{graphic_id}")

        eve_graphic.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseGraphic.new(id: graphic_id)
    end
  end
end
