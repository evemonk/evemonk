# frozen_string_literal: true
require 'rails_helper'

describe Eve::Item do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('inv_items') }

  it { should validate_presence_of(:flag_id) }

  it { should validate_presence_of(:item_id) }

  it { should validate_presence_of(:location_id) }

  it { should validate_presence_of(:owner_id) }

  it { should validate_presence_of(:quantity) }

  it { should validate_presence_of(:type_id) }

  it { should validate_numericality_of(:flag_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:item_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:location_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:owner_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(-1) }

  it { should validate_numericality_of(:type_id).only_integer.is_greater_than_or_equal_to(-1) }
end
