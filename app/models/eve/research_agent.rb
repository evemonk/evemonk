module Eve
  class ResearchAgent < ApplicationRecord
    self.table_name = 'agt_research_agents'

    validates :agent_id, presence: true

    validates :type_id, presence: true
  end
end
