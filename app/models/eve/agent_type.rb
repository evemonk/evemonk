# frozen_string_literal: true

module Eve
  class AgentType < ApplicationRecord
    self.table_name = 'agt_agent_types'

    validates :agent_type, presence: true

    validates :agent_type_id, presence: true

    validates :agent_type_id, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  end
end
