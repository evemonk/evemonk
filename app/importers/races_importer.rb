class RacesImporter
  attr_reader :chr_races

  def initialize(file)
    @chr_races = EveOnline::SDE::ChrRaces.new(file)
  end

  def execute
    chr_races.chr_races.each do |chr_race|
      Eve::Race.create!(chr_race.as_json)
    end
  end
end
