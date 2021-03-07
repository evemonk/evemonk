# frozen_string_literal: true

require "rails_helper"

describe Eve::FactionRecord, type: :model do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_factions") }

  it { should respond_to(:versions) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }
end
