# frozen_string_literal: true

require "rails_helper"

RSpec.describe Eve::Planet do
  it { is_expected.to be_an(ApplicationRecord) }

  it { expect(described_class.primary_key).to eq("planet_id") }

  it { expect(described_class.table_name).to eq("eve_planets") }

  it { is_expected.to belong_to(:system).optional(true) }

  it { is_expected.to belong_to(:type).optional(true) }

  it { is_expected.to have_many(:moons) }

  it { is_expected.to have_many(:asteroid_belts) }

  it { is_expected.to have_one(:position).dependent(:destroy) }
end
