# frozen_string_literal: true

require 'rails_helper'

describe Eve::Ancestry do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_ancestries') }

  it { should validate_presence_of(:ancestry_id) }

  it { should validate_numericality_of(:ancestry_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:bloodline_id) }

  it { should validate_numericality_of(:bloodline_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:description) }

  it { should validate_numericality_of(:icon_id).only_integer.is_greater_than_or_equal_to(0).allow_nil }
end
