# frozen_string_literal: true
class PositionsImporter
  attr_reader :inv_positions

  def initialize(file)
    @inv_positions = EveOnline::SDE::InvPositions.new(file)
  end

  def execute
    inv_positions.inv_positions.each do |inv_position|
      Eve::Position.create!(inv_position.as_json)
    end
  end
end
