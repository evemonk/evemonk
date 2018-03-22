# frozen_string_literal: true

module Eve
  class Bloodline < ApplicationRecord
    validates :bloodline_id, presence: true

    validates :bloodline_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :name, presence: true

    validates :description, presence: true

    validates :race_id, presence: true

    validates :race_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :ship_type_id, presence: true

    validates :ship_type_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :corporation_id, presence: true

    validates :corporation_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :perception, presence: true

    validates :perception, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :willpower, presence: true

    validates :willpower, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :charisma, presence: true

    validates :charisma, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :memory, presence: true

    validates :memory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    validates :intelligence, presence: true

    validates :intelligence, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
end
