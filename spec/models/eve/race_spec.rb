# frozen_string_literal: true
require 'rails_helper'

describe Eve::Race do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('chr_races') }

  it { should validate_presence_of(:race_id) }

  it { should validate_numericality_of(:race_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:race_name) }

  it { should validate_numericality_of(:icon_id).only_integer.is_greater_than_or_equal_to(0).allow_nil }
end
