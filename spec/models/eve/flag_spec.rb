require 'rails_helper'

describe Eve::Flag do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('inv_flags') }

  it { should validate_presence_of(:flag_id) }

  it { should validate_numericality_of(:flag_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:flag_name) }

  it { should validate_presence_of(:flag_text) }

  it { should validate_numericality_of(:order_id).only_integer.is_greater_than_or_equal_to(0) }
end
