# frozen_string_literal: true

module Eve
  class RegionImporter
    attr_reader :region_id, :locale

    def initialize(region_id, locale = :en)
      @region_id = region_id
      @locale = locale
    end

    def import
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          eve_region = Eve::Region.find_or_initialize_by(region_id: region_id)

          esi = EveOnline::ESI::UniverseRegion.new(id: region_id, language: LanguageMapper::LANGUAGES[locale])

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          eve_region.update!(esi.as_json)

          etag.update!(etag: esi.etag, body: esi.response)
        rescue EveOnline::Exceptions::ResourceNotFound
          eve_region.destroy!
        end
      end
    end
  end
end
