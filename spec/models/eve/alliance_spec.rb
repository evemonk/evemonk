# frozen_string_literal: true

require 'rails_helper'

describe Eve::Alliance do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_alliances') }

  it { should have_many(:characters).dependent(:destroy) }

  it { should validate_presence_of(:alliance_id) }

  it { should validate_numericality_of(:alliance_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:creator_id) }

  it { should validate_numericality_of(:creator_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:creator_corporation_id) }

  it { should validate_numericality_of(:creator_corporation_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:ticker) }

  it { should validate_numericality_of(:executor_corporation_id).only_integer.is_greater_than_or_equal_to(0).allow_nil }

  it { should validate_presence_of(:date_founded) }

  it { should validate_numericality_of(:faction_id).only_integer.is_greater_than_or_equal_to(0).allow_nil }
end
