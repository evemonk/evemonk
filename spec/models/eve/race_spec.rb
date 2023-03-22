# frozen_string_literal: true

require "rails_helper"

describe Eve::Race do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_races") }

  it { should belong_to(:faction).optional(true) }

  it { should have_many(:bloodlines) }

  it { should have_many(:stations) }
end
