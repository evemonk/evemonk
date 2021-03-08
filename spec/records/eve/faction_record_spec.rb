# frozen_string_literal: true

require "rails_helper"

describe Eve::FactionRecord, type: :model do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_factions") }

  # it { should respond_to(:versions) }
  #
  # it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }
  #
  # it { should belong_to(:militia_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").with_foreign_key("militia_corporation_id").optional(true) }
  #
  # it { should belong_to(:solar_system).class_name("Eve::System").with_primary_key("system_id").with_foreign_key("solar_system_id").optional(true) }

  it { should have_many(:alliances).class_name("Eve::AllianceRecord").with_primary_key("faction_id").with_foreign_key("faction_id") }

  # it { should have_many(:standings) }
end
