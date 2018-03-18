# frozen_string_literal: true

module Eve
  class Race < ApplicationRecord
    validates :race_id, presence: true

    validates :race_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :name, presence: true

    validates :description, presence: true

    validates :alliance_id, presence: true

    validates :alliance_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
