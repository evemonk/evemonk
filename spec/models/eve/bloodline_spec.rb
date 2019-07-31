# frozen_string_literal: true

require "rails_helper"

describe Eve::Bloodline do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_bloodlines") }

  it { should belong_to(:corporation).with_primary_key(:corporation_id).optional }

  it { should belong_to(:race).with_primary_key(:race_id).optional }
end
