# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Race do
  it { expect(subject).to be_an(ApplicationRecord) }

  it { expect(described_class).to respond_to(:translates) }

  it { expect(described_class.mobility_attributes).to eq(["name", "description"]) }

  it { expect(described_class.table_name).to eq("eve_races") }

  it { expect(subject).to belong_to(:faction).optional(true) }

  it { expect(subject).to have_many(:bloodlines) }

  it { expect(subject).to have_many(:stations) }
end
