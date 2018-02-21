# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe ResearchAgent do
    it { should be_a(ApplicationRecord) }

    it { expect(described_class.table_name).to eq('agt_research_agents') }

    it { should validate_presence_of(:agent_id) }

    it { should validate_presence_of(:type_id) }
  end
end
