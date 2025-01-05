# frozen_string_literal: true

module Eve
  class ConstellationImporter < BaseImporter
    attr_reader :constellation_id, :locale

    def initialize(constellation_id, locale = :en)
      @constellation_id = constellation_id
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          eve_constellation = Eve::Constellation.find_or_initialize_by(constellation_id: constellation_id)

          eve_constellation.update!(esi.as_json)

          eve_constellation.position&.destroy

          eve_constellation.create_position!(esi.position.as_json)
        rescue EveOnline::Exceptions::ResourceNotFound
          Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Constellation ID #{constellation_id}")

          eve_constellation.destroy!
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseConstellation.new(id: constellation_id, language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
