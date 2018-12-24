# frozen_string_literal: true

require 'rails_helper'

describe Eve::Alliance do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_alliances') }

  it { should belong_to(:creator_corporation).with_primary_key(:corporation_id).class_name('Eve::Corporation').optional }

  it { should belong_to(:creator).with_primary_key(:character_id).class_name('Eve::Character').optional }

  it { should belong_to(:executor_corporation).with_foreign_key(:executor_corporation_id).with_primary_key(:corporation_id).class_name('Eve::Corporation').optional }

  it { should belong_to(:faction).with_primary_key(:faction_id).optional }

  it { should have_many(:alliance_corporations).with_primary_key(:alliance_id) }

  it { should have_many(:corporations).through(:alliance_corporations) }
end
