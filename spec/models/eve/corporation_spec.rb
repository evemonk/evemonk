# frozen_string_literal: true

require 'rails_helper'

describe Eve::Corporation do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_corporations') }

  it { should validate_presence_of(:corporation_id) }

  it { should validate_numericality_of(:corporation_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:ticker) }

  it { should validate_presence_of(:member_count) }

  it { should validate_numericality_of(:member_count).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:ceo_id) }

  it { should validate_numericality_of(:ceo_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:tax_rate) }

  it { should validate_presence_of(:creator_id) }

  it { should validate_numericality_of(:creator_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:alliance_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:home_station_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_numericality_of(:shares).only_integer.is_greater_than_or_equal_to(0) }
end
