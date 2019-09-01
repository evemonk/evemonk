# frozen_string_literal: true

module Eve
  class TranslationsImporter
    def import
      locales = I18n.available_locales - [:en]

      locales.each do |locale|
        Mobility.with_locale(locale) do
          update_eve_races(locale)
        end
      end
    end

    private

    def update_eve_races(locale)
      esi = EveOnline::ESI::UniverseRaces.new(language: locale)

      etag = Eve::Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      esi.races.each do |race|
        eve_race = Eve::Race.find_or_initialize_by(race_id: race.race_id)

        eve_race.update!(name: race.name,
                         description: race.description)
      end

      etag.update!(etag: esi.etag)
    end

    # def update_eve_bloodlines(locale)
    #
    # end
  end
end

