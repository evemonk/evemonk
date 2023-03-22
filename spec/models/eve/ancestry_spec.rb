# frozen_string_literal: true

require "rails_helper"

describe Eve::Ancestry do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_ancestries") }

  it { should belong_to(:bloodline).optional(true) }

  it { should belong_to(:icon).optional(true) }
end
