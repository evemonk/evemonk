# frozen_string_literal: true

require "rails_helper"

describe Eve::Faction do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_factions") }

  it { should have_many(:alliances).with_primary_key(:faction_id) }

  it { should belong_to(:corporation).with_primary_key(:corporation_id).optional }

  it { should belong_to(:solar_system).with_foreign_key(:solar_system_id).with_primary_key(:system_id).class_name("Eve::System").optional }
end
