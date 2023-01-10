# frozen_string_literal: true

class CharacterStandingsFilterForm
  include ActiveModel::Model

  def filter
    [
      {name: "All", id: 0},
      {name: "BPO", id: 1},
      {name: "BPC", id: 2},
      {name: "Ancient Relics", id: 3},
      {name: "Stacked", id: 4}
    ].map(&:values)
  end

  def filter_selected

  end
end
