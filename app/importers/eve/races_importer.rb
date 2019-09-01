# frozen_string_literal: true

module Eve
  class RacesImporter
    def import
      Mobility.with_locale(:en) do
        ActiveRecord::Base.transaction do
          esi = EveOnline::ESI::UniverseRaces.new

          etag = Eve::Etag.find_or_initialize_by(url: esi.url)

          esi.etag = etag.etag

          return if esi.not_modified?

          esi.races.each do |race|
            eve_race = Eve::Race.find_or_initialize_by(race_id: race.race_id)

            eve_race.update!(race.as_json)
          end

          etag.update!(etag: esi.etag)
        end
      end
    end
  end
end
