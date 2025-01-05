# frozen_string_literal: true

module Eve
  class StarImporter < BaseImporter
    attr_reader :star_id

    def initialize(star_id)
      @star_id = star_id
    end

    def import
      import! do
        eve_star = Eve::Star.find_or_initialize_by(star_id: star_id)

        eve_star.update!(esi.as_json)
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Star ID #{star_id}")

        eve_star.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseStar.new(id: star_id)
    end
  end
end
