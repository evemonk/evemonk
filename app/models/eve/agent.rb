# frozen_string_literal: true
module Eve
  class Agent < ApplicationRecord
    self.table_name = 'agt_agents'

    validates :agent_id, presence: true

    validates :agent_type_id, presence: true

    validates :corporation_id, presence: true

    validates :division_id, presence: true

    validates :is_locator, inclusion: { in: [true, false] }

    validates :level, presence: true

    validates :location_id, presence: true

    validates :quality, presence: true

    validates :agent_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

    validates :agent_type_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

    validates :corporation_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

    validates :division_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

    validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

    validates :location_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

    validates :quality, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  end
end
