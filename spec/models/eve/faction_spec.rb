# frozen_string_literal: true

require 'rails_helper'

describe Eve::Faction do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_factions') }

  it { should validate_presence_of(:faction_id) }

  it { should validate_numericality_of(:faction_id).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:description) }

  it { should validate_numericality_of(:solar_system_id).only_integer.is_greater_than_or_equal_to(0).allow_nil }

  it { should validate_numericality_of(:corporation_id).only_integer.is_greater_than_or_equal_to(0).allow_nil }

  it { should validate_numericality_of(:militia_corporation_id).only_integer.is_greater_than_or_equal_to(0).allow_nil }

  it { should validate_presence_of(:size_factor) }

  it { should validate_presence_of(:station_count) }

  it { should validate_numericality_of(:station_count).only_integer.is_greater_than_or_equal_to(0) }

  it { should validate_presence_of(:station_system_count) }

  it { should validate_numericality_of(:station_system_count).only_integer.is_greater_than_or_equal_to(0) }
end
