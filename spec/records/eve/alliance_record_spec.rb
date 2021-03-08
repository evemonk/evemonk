# frozen_string_literal: true

require "rails_helper"

describe Eve::AllianceRecord, type: :model do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_alliances") }

  # TODO: more

  it { should belong_to(:faction).class_name("Eve::FactionRecord").with_primary_key("faction_id").with_foreign_key("faction_id").optional(true) }

  it { should have_many(:corporations).class_name("Eve::CorporationRecord").with_primary_key("alliance_id").with_foreign_key("alliance_id") }

  # TODO: more
end
