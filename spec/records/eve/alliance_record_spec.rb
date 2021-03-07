# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceRecord, type: :model do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_alliances") }

  # TODO: more

  it { should have_many(:corporation_records).with_primary_key("alliance_id").with_foreign_key("alliance_id") }

  # TODO: more
end
