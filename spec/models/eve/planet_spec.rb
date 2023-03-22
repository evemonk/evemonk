# frozen_string_literal: true

require "rails_helper"

describe Eve::Planet do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("planet_id") }

  it { expect(described_class.table_name).to eq("eve_planets") }

  it { should belong_to(:system).optional(true) }

  it { should belong_to(:type).optional(true) }

  it { should have_many(:moons) }

  it { should have_many(:asteroid_belts) }

  it { should have_one(:position).dependent(:destroy) }
end
