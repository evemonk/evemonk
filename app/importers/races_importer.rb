# frozen_string_literal: true

class RacesImporter
  def import
    races = EveOnline::ESI::Races.new

    races.races.each do |race|
      Eve::Race.create!(race.as_json)
    end
  end
end
