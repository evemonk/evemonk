# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceCorporation do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_alliance_corporations") }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).counter_cache(:corporations_count).optional }

  it { should belong_to(:corporation).with_primary_key(:corporation_id).optional }
end
