# frozen_string_literal: true

class RacesImporter
  def import
    races = EveOnline::ESI::Races.new.races

    races.each do |race|
      eve_race = Eve::Race.find_or_initialize_by(race_id: race.race_id)

      eve_race.update!(race.as_json)
    end
  end
end
