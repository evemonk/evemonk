class PositionsImporter
  attr_reader :positions

  def initialize(file)
    @positions = EveOnline::SDE::Positions.new(file)
  end

  def execute
    positions.positions.each do |position|
      Eve::Position.create!(position.as_json)
    end
  end
end
