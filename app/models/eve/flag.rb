module Eve
  class Flag < ApplicationRecord
    self.table_name = 'inv_flags'

    validates :flag_id, presence: true

    validates :flag_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :flag_name, presence: true

    validates :flag_text, presence: true

    validates :order_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
