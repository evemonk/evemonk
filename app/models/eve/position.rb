module Eve
  class Position < ApplicationRecord
    self.table_name = 'inv_positions'

    validates :item_id, presence: true

    validates :x, presence: true

    validates :y, presence: true

    validates :z, presence: true

    validates :item_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
