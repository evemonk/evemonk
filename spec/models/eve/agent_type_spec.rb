require 'rails_helper'

describe Eve::AgentType do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('agt_agent_types') }

  it { should validate_presence_of(:agent_type) }

  it { should validate_presence_of(:agent_type_id) }

  it { should validate_numericality_of(:agent_type_id).only_integer.is_greater_than_or_equal_to(1) }
end
