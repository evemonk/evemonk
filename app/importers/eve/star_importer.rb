# frozen_string_literal: true

module Eve
  class StarImporter
    attr_reader :star_id

    def initialize(star_id)
      @star_id = star_id
    end

    def import
      ActiveRecord::Base.transaction do
        eve_star = Eve::Star.find_or_initialize_by(star_id: star_id)

        esi = EveOnline::ESI::UniverseStar.new(id: star_id)

        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        eve_star.update!(esi.as_json)

        etag.update!(etag: esi.etag, body: esi.response)
      rescue EveOnline::Exceptions::ResourceNotFound
        eve_star.destroy!
      end
    end
  end
end
