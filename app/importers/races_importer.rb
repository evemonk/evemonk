# frozen_string_literal: true
class RacesImporter
  attr_reader :races

  def initialize(file)
    @races = EveOnline::SDE::Races.new(file)
  end

  def execute
    races.races.each do |race|
      Eve::Race.create!(race.as_json)
    end
  end
end
