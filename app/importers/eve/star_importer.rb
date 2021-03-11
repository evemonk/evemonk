# frozen_string_literal: true

# TODO: update
module Eve
  class StarImporter < BaseImporter
    attr_reader :star_id

    def initialize(star_id)
      @star_id = star_id
    end

    def import
      import! do
        eve_star = Eve::Star.find_or_initialize_by(star_id: star_id)

        return if esi.not_modified?

        eve_star.update!(esi.as_json)

        update_etag
      rescue EveOnline::Exceptions::ResourceNotFound
        Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Star ID #{star_id}")

        etag.destroy!

        eve_star.destroy!
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseStar.new(id: star_id)
    end
  end
end
