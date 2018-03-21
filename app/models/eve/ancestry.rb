# frozen_string_literal: true

module Eve
  class Ancestry < ApplicationRecord
    validates :ancestry_id, presence: true

    validates :ancestry_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :name, presence: true

    validates :bloodline_id, presence: true

    validates :bloodline_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :description, presence: true

    validates :icon_id, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  end
end
