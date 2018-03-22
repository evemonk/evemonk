# frozen_string_literal: true

module Eve
  class Alliance < ApplicationRecord
    validates :alliance_id, presence: true

    validates :alliance_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :creator_id, presence: true

    validates :creator_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :creator_corporation_id, presence: true

    validates :creator_corporation_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :ticker, presence: true

    validates :executor_corporation_id, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

    validates :date_founded, presence: true

    validates :faction_id, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  end
end
