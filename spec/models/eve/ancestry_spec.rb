# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Ancestry, type: :model do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_ancestries") }

  it { expect(subject).to belong_to(:bloodline).optional(true) }

  it { expect(subject).to belong_to(:icon).optional(true) }
end
