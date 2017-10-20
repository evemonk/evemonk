# frozen_string_literal: true
module Eve
  class Name < ApplicationRecord
    self.table_name = 'inv_names'

    validates :item_id, presence: true

    validates :item_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
