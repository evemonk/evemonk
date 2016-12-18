class PositionsImporter
  attr_reader :positions

  def initialize(file)
    @positions = EveOnline::SDE::Base.new(file)
  end

  def execute
    positions.data.each do |position|
      Eve::Position.create!(position)
    end
  end
end
