# frozen_string_literal: true

require "rails_helper"

describe Eve::Race do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.translated_attribute_names).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_races") }

  it { should belong_to(:faction).with_primary_key("faction_id").optional(true) }

  it { should have_many(:bloodlines).with_primary_key("race_id") }

  it { should have_many(:stations).with_primary_key("race_id") }
end
