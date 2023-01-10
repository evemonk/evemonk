# frozen_string_literal: true

class CharacterStandingsFilterForm
  include ActiveModel::Model

  attr_accessor :filter

  def initialize(filter)
    @filter = filter
  end

  def select_data
    raw_values.map(&:values)
  end

  def selected
    filter
  end

  private

  def raw_values
    [
      {name: "All", id: 0},
      {name: "BPO", id: 1},
      {name: "BPC", id: 2},
      {name: "Ancient Relics", id: 3},
      {name: "Stacked", id: 4}
    ]
  end
end
