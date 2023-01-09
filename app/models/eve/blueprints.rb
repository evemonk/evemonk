# frozen_string_literal: true

module Eve
  class Blueprints
    class << self
      def filter
        [
          {name: "All", id: 0},
          {name: "BPO", id: 1},
          {name: "BPC", id: 2},
          {name: "Ancient Relics", id: 3},
          {name: "Stacked", id: 4}
        ].map(&:values)
      end
    end
  end
end
