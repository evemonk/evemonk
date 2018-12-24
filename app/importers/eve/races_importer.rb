# frozen_string_literal: true

module Eve
  class RacesImporter
    def import
      current_etag = Redis.current.get("races:#{ I18n.locale }:etag")

      eveonline_esi_races = EveOnline::ESI::UniverseRaces.new(etag: current_etag)

      return if eveonline_esi_races.not_modified?

      eveonline_esi_races.races.each do |race|
        eve_race = Eve::Race.find_or_initialize_by(race_id: race.race_id)

        eve_race.assign_attributes(race.as_json)

        eve_race.save! if eve_race.changed?
      end

      Redis.current.set("races:#{ I18n.locale }:etag", eveonline_esi_races.etag)
    end
  end
end
