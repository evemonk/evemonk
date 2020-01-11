# frozen_string_literal: true

module Eve
  class ConstellationImporter
    attr_reader :constellation_id, :locale

    def initialize(constellation_id, locale = :en)
      @constellation_id = constellation_id
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          eve_constellation = Eve::Constellation.find_or_initialize_by(constellation_id: constellation_id)

          esi = EveOnline::ESI::UniverseConstellation.new(id: constellation_id, language: LanguageMapper::LANGUAGES[locale])

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          eve_constellation.update!(esi.as_json)

          eve_constellation.position&.destroy

          eve_constellation.create_position!(esi.position.as_json)

          etag.update!(etag: esi.etag, body: esi.response)
        rescue EveOnline::Exceptions::ResourceNotFound
          eve_constellation.destroy!
        end
      end
    end
  end
end
