class RacesImporter
  attr_reader :races

  def initialize(file)
    @races = EveOnline::SDE::Base.new(file)
  end

  def execute
    races.data.each do |race|
      Eve::Race.create!(race)
    end
  end
end
