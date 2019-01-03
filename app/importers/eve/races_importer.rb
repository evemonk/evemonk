# frozen_string_literal: true

module Eve
  class RacesImporter
    def import
      eveonline_esi_races = EveOnline::ESI::UniverseRaces.new

      etag = Etag.find_or_initialize_by(url: eveonline_esi_races.url)

      eveonline_esi_races.etag = etag.etag

      return if eveonline_esi_races.not_modified?

      eveonline_esi_races.races.each do |race|
        eve_race = Eve::Race.find_or_initialize_by(race_id: race.race_id)

        eve_race.update!(race.as_json)
      end

      etag.update!(etag: eveonline_esi_races.etag)
    end
  end
end
