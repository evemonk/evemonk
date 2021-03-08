# frozen_string_literal: true

module Eve
  class RacesImporter < BaseImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      import! do
        return if esi.not_modified?

        esi.races.each do |race|
          input = RaceInput.new(race_id: race.race_id,
                                faction_id: race.faction_id,
                                "description_#{locale}": race.description,
                                "name_#{locale}": race.name)

          RaceRepository.update(race.race_id, input, locale)
        end

        update_etag
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseRaces.new(language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
