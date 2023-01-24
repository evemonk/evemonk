# frozen_string_literal: true

module Eve
  class RegionImporter < BaseImporter
    attr_reader :region_id, :locale

    def initialize(region_id, locale = :en)
      @region_id = region_id
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          eve_region = Eve::Region.find_or_initialize_by(region_id: region_id)

          eve_region.update!(esi.as_json)
        rescue EveOnline::Exceptions::ResourceNotFound
          Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Region ID #{region_id}")

          eve_region.destroy!
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseRegion.new(id: region_id, language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
