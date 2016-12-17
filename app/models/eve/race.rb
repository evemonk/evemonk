module Eve
  class Race < ApplicationRecord
    self.table_name = 'chr_races'

    validates :race_id, presence: true

    validates :race_id, numericality: { only_integer: true, greater_than: 0 }

    validates :race_name, presence: true

    validates :icon_id, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  end
end
