require 'rails_helper'

describe Eve::Agent do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('agt_agents') }

  it { should validate_presence_of(:agent_id) }

  it { should validate_presence_of(:agent_type_id) }

  it { should validate_presence_of(:corporation_id) }

  it { should validate_presence_of(:division_id) }

  it { should validate_inclusion_of(:is_locator).in_array([true, false]) }

  it { should validate_presence_of(:level) }

  it { should validate_presence_of(:location_id) }

  it { should validate_presence_of(:quality) }

  it { should validate_numericality_of(:agent_id).only_integer.is_greater_than_or_equal_to(1) }

  it { should validate_numericality_of(:agent_type_id).only_integer.is_greater_than_or_equal_to(1) }

  it { should validate_numericality_of(:corporation_id).only_integer.is_greater_than_or_equal_to(1) }

  it { should validate_numericality_of(:division_id).only_integer.is_greater_than_or_equal_to(1) }

  it { should validate_numericality_of(:level).only_integer.is_greater_than_or_equal_to(1) }

  it { should validate_numericality_of(:location_id).only_integer.is_greater_than_or_equal_to(1) }

  it { should validate_numericality_of(:quality).only_integer.is_greater_than_or_equal_to(1) }
end
