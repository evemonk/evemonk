# frozen_string_literal: true

require "rails_helper"

describe Eve::Faction do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_factions") }

  it { should belong_to(:corporation).with_primary_key("corporation_id").optional(true) }

  it { should belong_to(:militia_corporation).class_name("Eve::Corporation").with_primary_key("corporation_id").with_foreign_key("militia_corporation_id").optional(true) }

  it { should belong_to(:solar_system).class_name("Eve::System").with_primary_key("system_id").with_foreign_key("solar_system_id").optional(true) }

  it { should have_many(:alliances).with_primary_key("faction_id") }

  it { should have_many(:standings) }
end
