module Eve
  class Item < ApplicationRecord
    self.table_name = 'inv_items'

    validates :flag_id, presence: true

    validates :item_id, presence: true

    validates :location_id, presence: true

    validates :owner_id, presence: true

    validates :quantity, presence: true

    validates :type_id, presence: true

    validates :flag_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :item_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :location_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :owner_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: -1 }

    validates :type_id, numericality: { only_integer: true, greater_than_or_equal_to: -1 }
  end
end
