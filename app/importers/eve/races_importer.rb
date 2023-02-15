# frozen_string_literal: true

module Eve
  class RacesImporter < BaseImporter
    attr_reader :locale

    def initialize(locale = :en)
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          esi.races.each do |race|
            eve_race = Eve::Race.find_or_initialize_by(id: race.race_id)

            eve_race.update!(race.as_json.transform_keys(race_id: :id))
          end
        end
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseRaces.new(language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
