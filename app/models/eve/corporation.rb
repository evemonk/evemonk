# frozen_string_literal: true

module Eve
  class Corporation < ApplicationRecord
    validates :corporation_id, presence: true

    validates :corporation_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :name, presence: true

    validates :ticker, presence: true

    validates :member_count, presence: true

    validates :member_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :ceo_id, presence: true

    validates :ceo_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :tax_rate, presence: true

    validates :creator_id, presence: true

    validates :creator_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :alliance_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :home_station_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :shares, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
